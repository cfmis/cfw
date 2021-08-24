//验证是否为整數
function isInt(value) {
    var patrn = /^-?\d+$/;
    if (patrn.exec(value) == null || value == "") {
        return false
    } else {
        return true
    }
}

//驗證是否為數字
function isFloatValue(value) {
    var patrn = /^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$/;
    if (patrn.exec(value) == null || value == "") {
        return false
    } else {
        return true
    }
}

//驗證是否為數字
function isNumber(value) {
    var patrn = /^(-?\d+)(\.\d+)?$/;
    if (patrn.exec(value) == null || value == "") {
        return false
    } else {
        return true
    }
}
//验证数字的正则表达式集 
//验证数字：^[0-9]*$ 
//验证n位的数字：^\d{n}$ 
//验证至少n位数字：^\d{n,}$ 
//验证m-n位的数字：^\d{m,n}$ 
//验证零和非零开头的数字：^(0|[1-9][0-9]*)$ 
//验证有两位小数的正实数：^[0-9]+(.[0-9]{2})?$ 
//验证有1-3位小数的正实数：^[0-9]+(.[0-9]{1,3})?$ 
//验证非零的正整数：^\+?[1-9][0-9]*$ 
//验证非零的负整数：^\-[1-9][0-9]*$ 
//验证非负整数（正整数 + 0） ^\d+$ 
//验证非正整数（负整数 + 0） ^((-\d+)|(0+))$ 
//验证长度为3的字符：^.{3}$ 
//验证由26个英文字母组成的字符串：^[A-Za-z]+$ 
//验证由26个大写英文字母组成的字符串：^[A-Z]+$ 
//验证由26个小写英文字母组成的字符串：^[a-z]+$ 
//验证由数字和26个英文字母组成的字符串：^[A-Za-z0-9]+$ 
//验证由数字、26个英文字母或者下划线组成的字符串：^\w+$ 
//验证用户密码:^[a-zA-Z]\w{5,17}$ 正确格式为：以字母开头，长度在6-18之间，只能包含字符、数字和下划线。 
//验证是否含有 ^%&',;=?$\" 等字符：[^%&',;=?$\x22]+ 
//验证汉字：^[\u4e00-\u9fa5],{0,}$ 
//验证Email地址：/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/
//验证InternetURL：^http://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$ ；^[a-zA-z]+://(w+(-w+)*)(.(w+(-w+)*))*(?S*)?$ 
//验证电话号码：^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$：--正确格式为：XXXX-XXXXXXX，XXXX-XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX。 
//验证身份证号（15位或18位数字）：^\d{15}|\d{}18$ 
//验证一年的12个月：^(0?[1-9]|1[0-2])$ 正确格式为：“01”-“09”和“1”“12” 
//验证一个月的31天：^((0?[1-9])|((1|2)[0-9])|30|31)$ 正确格式为：01、09和1、31。 
//整数：^-?\d+$ 
//非0整數：^\+?[1-9][0-9]*$
//非负浮点数（正浮点数 + 0）：^\d+(\.\d+)?$ 
//正浮点数 ^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$ 
//非正浮点数（负浮点数 + 0） ^((-\d+(\.\d+)?)|(0+(\.0+)?))$ 
//负浮点数 ^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$ 
//浮点数 ^(-?\d+)(\.\d+)?$


//調用網頁時，获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}

//設置日期格式：YYYY/MM/DD
function myformatter(date) {
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    var d = date.getDate();
    return y + '/' + (m < 10 ? ('0' + m) : m) + '/' + (d < 10 ? ('0' + d) : d);
}

////轉換日期格式：YYYY/MM/DD
//function changeDateFormatter(date) {
//    var y = date.getFullYear();
//    var m = date.getMonth() + 1;
//    var d = date.getDate();
//    return y + '/' + (m < 10 ? ('0' + m) : m) + '/' + (d < 10 ? ('0' + d) : d);

//}

//function changeDateParser(s) {
//    if (!s) return new Date();
//    var ss = (s.split('/'));
//    var y = parseInt(ss[0], 10);
//    var m = parseInt(ss[1], 10);
//    var d = parseInt(ss[2], 10);
//    if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
//        return new Date(y, m - 1, d);
//    } else {
//        return new Date();
//    }
//}

//轉換日期格式：YYYY/MM/DD
function changeDateToChar(value) {
    if (value != null) {
        var date = new Date(value);
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        m = m < 10 ? ('0' + m) : m;
        var d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        var h = date.getHours();
        var minute = date.getMinutes();
        minute = minute < 10 ? ('0' + minute) : minute;
        var second = date.getSeconds();
        second = second < 10 ? ('0' + second) : second;
        //alert(y + '-' + m + '-' + d + ' ' + h + ':' + minute + ":" + second);
        //var dd = y + '/' + m + '/' + d;
        return y + '/' + m + '/' + d;
    } else {
        return "";
    }
}

function showLoadingDialog() {
    var title = '正在查詢記錄，請稍候。。。';
    var content = '';
    content += '<p style="text-align: center; vertical-align: central;">';
    content += '<img src="../images/splash.gif" />';
    content += '</p>';
    var boarddiv = '<div id="msgwindow" title="' + title + '"></div>';//style="overflow:hidden;"可以去掉滚动条

    $(document.body).append(boarddiv);
    var win = $('#msgwindow').dialog({
        content: content,
        width: 200,
        height: 130,
        modal: true,
        title: title,
        closable: false,
    });
    win.dialog('open');
}

function closeLoadingWindow() {
    $('#msgwindow').dialog('close');
}