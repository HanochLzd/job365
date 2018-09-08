<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="../common/taglibs.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <title>job365后台管理系统</title>
    <script type="text/javascript">
        $(function () {
            var flag = true;

            $("#login-form").submit(function () {

                if (flag) {
                    var url = "<%=basePath%>login/doLogin.do";
                    $.post(url, $("#login-form").serialize(), function (data) {

                        var jsonReturn = eval("(" + data + ")");

                        if (jsonReturn.code == "1") {

                            layer.alert(jsonReturn.msg, {icon: 6, time: 0}, function (data) {
                                location.href = "<%=basePath%>login/main/index.do";
                            });

                        } else {

                            layer.msg(jsonReturn.msg, {icon: 5, time: 3000});
                        }
                    });
                }


                return false;
            });

        });

        function register(title, url, w, h) {
            var url = "<%=basePath%>login/doRegister";
            <%-- window.location.href="<%=basePath%>login/doRegister.do"; --%>

            layer_show(title, url, w, h);
            //alert(url);
            //window.location.href="register.jsp"
        }
    </script>
</head>
<body>

<div class="loginWraper">
    <div id="loginform" class="loginBox">
        <h2 style="margin-left:30%;color:#eee;font-family:" 微软雅黑">job365后台管理系统登录</h2>
        <form class="form form-horizontal" action="#" id="login-form" method="post" style="margin-top:35px;">
            <div class="row cl">
                <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60d;</i></label>
                <div class="formControls col-xs-8">
                    <input id="userName" name="userName" type="text" placeholder="账号" class="input-text size-L">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60e;</i></label>
                <div class="formControls col-xs-8">
                    <input id="password" name="password" type="password" placeholder="密码" class="input-text size-L">
                </div>
            </div>
            <div class="row cl">
                <div class="formControls col-xs-8 col-xs-offset-3">
                    <input name="" type="submit" class="btn btn-success radius size-L"
                           value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;"
                           style="margin-left:5%; padding-left:20px;">
                    <a href="javascript:;" style="margin-left:15%; " class="btn btn-success radius size-L"
                       onclick="register()"
                       value="&nbsp;注&nbsp;&nbsp;&nbsp;&nbsp;册&nbsp;">&nbsp;注&nbsp;&nbsp;&nbsp;&nbsp;册&nbsp;</a>
                </div>
            </div>
        </form>
    </div>
</div>
<div class="footer">Copyright &copy;www.job365.com</div>

</body>
</html>