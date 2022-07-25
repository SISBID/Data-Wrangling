var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'bioc-software.html'

page.open('http://bioconductor.org/packages/release/BiocViews.html#___Software', function (status) {
  var content = page.content;
  fs.write(path,content,'w')
  phantom.exit();
});