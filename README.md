
### XPath to GraphViz dot


Started as a [question on Stack Overflow](https://stackoverflow.com/questions/36327815/converting-random-xml-file-to-tree-diagram/36349048#36349048)
but now gets used enough to keep around.

### Requirements:
 -  A way to generate [xpaths](https://en.wikipedia.org/wiki/XPath)
 from am XML file I use [xmlstarlet](https://en.wikipedia.org/wiki/XMLStarlet)
 -  This xpath2dot [awk](https://en.wikipedia.org/wiki/AWK) script.
 -  A way to directly view or convert to image a [Graphvix dot file](https://en.wikipedia.org/wiki/Graphviz)

### Usage:


```
curl -s ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/xml/sample_xml/RCV000077146.xml |\
 xmlstarlet el -u | xpath2dot.awk | dot -T png > xpath2dot_demo.png
```

### Result:


![Example xpath2dot output](https://raw.githubusercontent.com/TomConlin/xpath2dot/master/xpath2dot_demo.png.png)
