/*获取到Url里面的参数*/
(function ($) {
  $.getUrlParam = function (id) {
    //正则匹配规则
    var reg = new RegExp("(^|&)" + id + "=([^&]*)(&|$)");
    //对传入的url进行正则匹配
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
  }
})(jQuery);

function removeHTMLTag(str) {
  str = str.replace(/<\/?[^>]*>/g, ''); //去除HTML tag
  str = str.replace(/[ | ]*\n/g, '\n'); //去除行尾空白
  //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
  str = str.replace(/ /ig, ''); //去掉
  return str;
}