#! /usr/bin/awk -f

#  xpath2dot.awk

#  xpaths describe how to address an element in an xml document
#  xmlstarlet can emit all the xpaths from an xml document
#  this script transforms a list of xpaths into a GraphViz dot file
#  to capture the relations between elements expressed in the xpaths

# C symbols are limited to upper+lower+digits+underscore
# should be < 32 long and not begin with a digit
# but we are not enforcing inital char or length here
# just replacing runs of non-alphanums with underscore
# so they can be used as node labels in dot
function sanitize(var){
	gsub(/[ !"#$%&'()*+,\-./:;<=>?@[\\\]\^_`{|}~]+/, "_", var);
	return var
}
 
BEGIN{
	FS="/";
}

# xpaths with at least two elements will be either:
#	an edge between nodes
#	or an attribute within a node
# it is only the last two elements in each xpath we are capturing

NF > 1 {
	if(1 == match($NF, "@")){
		att = sanitize(substr($NF,2));
		leaf = sanitize($(NF-1));
		if(node[leaf] != 0){
			node[leaf] = node[leaf] " | " att
		} else {
			node[leaf] = att
		}
	} else {
		# storing edges in an assocative array means parallel edges collapse
		edge[sanitize($(NF-1)) " -> " sanitize($(NF)) ]++;
	}
}

END{
	print "digraph{"
	print "rankdir=LR; charset=\"utf-8\";"
	for(n in node){
		print n " [label = \"{<" n "> " n " | " node[n] "}\" shape = \"record\"];"
	}
	# note well
	# edge weight relates to _reuse_ of element names within the xml schema
	# and not reuse of a particular element
	for(e in edge){print e " [penwidth = \"" edge[e] "\"];"}
	print"}"
}
