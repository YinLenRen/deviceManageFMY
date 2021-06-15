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