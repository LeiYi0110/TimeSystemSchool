<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html class="login-bg"><head>
	<title>阳光驾培-深圳酷商时代</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <!-- bootstrap -->
    <link href="${ctx}/resources/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="${ctx}/resources/css/bootstrap/bootstrap-responsive.css" rel="stylesheet" />
    <link href="${ctx}/resources/css/bootstrap/bootstrap-overrides.css" type="text/css" rel="stylesheet" />

    <!-- global styles -->
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/elements.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/icons.css" />

    <!-- libraries -->
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/lib/font-awesome.css" />
    
    <!-- this page specific styles -->
    <link rel="stylesheet" href="${ctx}/resources/css/compiled/signin.css" type="text/css" media="screen" />
    
</head>
<body>
<!--[if lt IE 9]>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"> </script>
<script type="text/javascript">
!function(e) {
    "use strict";
    var t = function(e, n, o) {
        return 1 === arguments.length ? t.get(e) : t.set(e, n, o)
    };
    t._document = document,
    t._navigator = navigator,
    t.defaults = {
        path: "/"
    },
    t.get = function(e) {
        return t._cachedDocumentCookie !== t._document.cookie && t._renewCache(),
        t._cache[e]
    },
    t.set = function(n, o, r) {
        return r = t._getExtendedOptions(r),
        r.expires = t._getExpiresDate(o === e ? -1 : r.expires),
        t._document.cookie = t._generateCookieString(n, o, r),
        t
    },
    t.expire = function(n, o) {
        return t.set(n, e, o)
    },
    t._getExtendedOptions = function(n) {
        return {
            path: n && n.path || t.defaults.path,
            domain: n && n.domain || t.defaults.domain,
            expires: n && n.expires || t.defaults.expires,
            secure: n && n.secure !== e ? n.secure: t.defaults.secure
        }
    },
    t._isValidDate = function(e) {
        return "[object Date]" === Object.prototype.toString.call(e) && !isNaN(e.getTime())
    },
    t._getExpiresDate = function(e, n) {
        switch (n = n || new Date, typeof e) {
        case "number":
            e = new Date(n.getTime() + 1e3 * e);
            break;
        case "string":
            e = new Date(e)
        }
        if (e && !t._isValidDate(e)) throw new Error("`expires` parameter cannot be converted to a valid Date instance");
        return e
    },
    t._generateCookieString = function(e, t, n) {
        e = e.replace(/[^#$&+\^`|]/g, encodeURIComponent),
        e = e.replace(/\(/g, "%28").replace(/\)/g, "%29"),
        t = (t + "").replace(/[^!#$&-+\--:<-\[\]-~]/g, encodeURIComponent),
        n = n || {};
        var o = e + "=" + t;
        return o += n.path ? ";path=" + n.path: "",
        o += n.domain ? ";domain=" + n.domain: "",
        o += n.expires ? ";expires=" + n.expires.toUTCString() : "",
        o += n.secure ? ";secure": ""
    },
    t._getCookieObjectFromString = function(n) {
        for (var o = {},
        r = n ? n.split("; ") : [], i = 0; i < r.length; i++) {
            var a = t._getKeyValuePairFromCookieString(r[i]);
            o[a.key] === e && (o[a.key] = a.value)
        }
        return o
    },
    t._getKeyValuePairFromCookieString = function(e) {
        var t = e.indexOf("=");
        return t = 0 > t ? e.length: t,
        {
            key: decodeURIComponent(e.substr(0, t)),
            value: decodeURIComponent(e.substr(t + 1))
        }
    },
    t._renewCache = function() {
        t._cache = t._getCookieObjectFromString(t._document.cookie),
        t._cachedDocumentCookie = t._document.cookie
    },
    t._areEnabled = function() {
        var e = "cookies.js",
        n = "1" === t.set(e, 1).get(e);
        return t.expire(e),
        n
    },
    t.enabled = t._areEnabled(),
    "function" == typeof define && define.amd ? define(function() {
        return t
    }) : "undefined" != typeof exports ? ("undefined" != typeof module && module.exports && (exports = module.exports = t), exports.Cookies = t) : window.Cookies = t
} ();
</script>
<style type="text/css">
#thp_notf_div {position: fixed;font-family:\5fae\8f6f\96c5\9ed1,Arial,verdana,Helvetica;}
.hpn_top_container {background: none repeat scroll 0 0 #fffadd;line-height:40px;height:40px;position: absolute;top:0;width: 100%;z-index: 2000;border-top:1px solid #f5e29d;border-bottom:1px solid #f5e29d;text-align:center;}
.hpn_top_desc {color: #604e29;}
.hpn_top_link, .hpn_top_link:visited, .hpn_top_link:hover { background-color:#46b802; color:#fff; padding:5px 10px; font-size:14px; line-height:18px;}
.hpn_top_close { background-color:#fffceb; color:#604e29; padding:4px 10px; font-size:14px; line-height:18px; border:1px solid #eada7e;}
</style>
<div id="thp_notf_div" class="hpn_top_container" style="display:none;top:0px;">
	<span class="hpn_top_desc">浏览器更新提示：你使用的浏览器版本较低，严重影响上网速度和使用操作体验，请使用我们推荐的浏览器。</span>
	<a href="javascript:void(0);" class="hpn_top_link" >请立即下载</a>
	<a href="#" class="hpn_top_close">关闭提示</a>
</div>
<script type="text/javascript">
Cookies.defaults = {
    path: '/'
};
// 用于清除cookies的代码，调试完提示框的样式后可以删除。
// Cookies('view', undefined);
if(Cookies.get('view') === undefined) {
	$("#thp_notf_div").slideDown();
}   
$(".hpn_top_close").click(function(){
	$("#thp_notf_div").slideUp();
});
$(".hpn_top_link").click(function(){
    Cookies.set('view', 1);
	location.href = "http://sw.bos.baidu.com/sw-search-sp/software/a7958cfcdbd6e/ChromeStandalone_53.0.2785.116_Setup.exe";
});
</script>
<![endif]-->
    <div class="row-fluid login-wrapper">
        <a href="index.html">
            <img class="logo" src="resources/img/logo-white.png" style="height:100px;"/>
        </a>

        <div class="span4 box">
            <div class="content-wrap">
            	<form action="${ctx}/security_check" method="post">
	                <h6>登 录</h6>
	                <input class="span12" type="text" name="username" placeholder="姓名" value=""/>
	                <input class="span12" type="password" name="password" placeholder="输入你的密码" value=""/>
	                
	                <div class="remember">
	                    <input id="remember-me" type="checkbox" />
	                    <label for="remember-me">记住密码</label>
                        <a href="#" class="forgot">忘记密码?</a>
	                </div>
	                <button type="submit" class="btn-glow primary login" >登录</button>
                </form>
            </div>
        </div>
    </div>

	<!-- scripts -->
    
    


</body>
</html>