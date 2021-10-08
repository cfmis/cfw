/*向文档中输出n个空格*/
function writeSpaces(n) {
    for (var i = 0; i < n; i++) {
        document.write("&nbsp;");
    }
}
/*打印预览*/
function preview() {
    bdhtml = window.document.body.innerHTML;
    sprnstr = "<!--startprint-->";
    eprnstr = "<!--endprint-->";
    prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
    prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
    window.document.body.innerHTML = prnhtml;
    window.print();
    window.document.body.innerHTML = bdhtml;
}
