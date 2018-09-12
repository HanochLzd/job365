<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="../../common/taglibs.jsp" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>My JSP 'user_add.jsp' starting page</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <style type="text/css">


    </style>
    <script type="text/javascript">
        $(function () {

            document.getElementById("count").innerHTML = "${user.remark}".length.toString();

            $('.skin-minimal input').iCheck({
                checkboxClass: 'icheckbox-blue',
                radioClass: 'iradio-blue',
                increaseArea: '20%'
            });

            $("#form-user-add").validate({
                rules: {
                    userNum: {
                        required: true,
                        number: true
                    },
                    userName: {
                        required: true,
                        minlength: 4,
                        maxlength: 16
                    },
                    realName: {
                        required: true,
                        minlength: 2,
                        maxlength: 16
                    },
                    gender: {
                        required: true,
                    },

                    userEmail: {
                        required: true,
                        email: true,
                    },

                },
                onkeyup: false,
                focusCleanup: true,
                success: "valid",
                submitHandler: function (form) {
                    $.post('<%=basePath%>user/saveUser', $(form).serialize(), function (data) {
                        var jsonReturn = eval('(' + data + ')');
                        console.log(jsonReturn);
                        if (jsonReturn.code == 1) {
                            layer.alert(jsonReturn.msg, {icon: 6, time: 0}, function (data) {
                                var index = parent.layer.getFrameIndex(window.name);
                                window.parent.location.reload(true);
                                parent.layer.close(index);

                            });

                        }

                    });
                }
            });

        });


        function checkLen(obj) {

            var maxChars = 100;//最多字符数

            if (obj.value.length > maxChars) obj.value = obj.value.substring(0, maxChars);

            var curr = obj.value.length;

            document.getElementById("count").innerHTML = curr.toString();

        }

        function checkUserNum(obj) {
            if (obj.value.length == 12) {
                var url = "<%=basePath%>sysUser/checkUserNum.do";
                $.post(url, {"userNum": obj.value}, function (data) {
                    var jsonReturn = eval("(" + data + ")");
                    if (jsonReturn.code == "0") {

                        layer.alert(jsonReturn.msg, {icon: 5, time: 0}, function (data) {
                            location.reload(true);
                        });
                    }
                });
            } else {
                layer.alert("请输入正确的学工号", {icon: 5, time: 0}, function (data) {
                    location.reload(true);
                });
            }

        }
    </script>
</head>

<body>
<article class="page-container">
    <form action="" method="post" class="form form-horizontal" id="form-user-add">

        <input type="hidden" id="op" name="op" value="${op}">
        <input type="hidden" id="id" name="id" value="${user.id}">

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>用户名：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="${user.userName}" placeholder="" id="userName"
                       name="userName">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>真实姓名：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="${user.realName}" placeholder="" id="realName"
                       name="realName">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>性别：</label>
            <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                <div class="radio-box">
                    <input name="gender" type="radio" id="male" value="0"
                           <c:if test="${op == 'add'}">checked="checked"</c:if>
                           <c:if test="${op == 'modify' && user.gender == 0}">checked="checked"</c:if>>
                    <label for="sex-1">男</label>
                </div>
                <div class="radio-box">
                    <input name="gender" type="radio" id="female" value="1"
                           <c:if test="${op == 'modify' && user.gender == 1}">checked="checked"</c:if>>
                    <label for="sex-2">女</label>
                </div>
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>电话：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" placeholder="@" value="${user.phone}" name="phone" id="phone"
                       maxlength="11">
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>邮箱：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" placeholder="@" value="${user.email}" name="email" id="userEmail">
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>地址：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" placeholder="@" value="${user.address}" name="address"
                       id="address">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">备注：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <textarea name="remark" id="userRemark" cols="" rows="" class="textarea" placeholder="说点什么..."
                          onkeyup="checkLen(this)">${user.remark }</textarea>
                <p class="textarea-numberbar"><em class="textarea-length"><span id="count">100</span></em>/100</p>
            </div>
        </div>
        <c:if test="${op == 'modify'}">
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>状态：</label>
                <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                    <div class="radio-box">
                        <input name="status" type="radio" id="userStatus_0" value="0"
                               <c:if test="${op == 'add'}">checked="checked"</c:if>
                               <c:if test="${op == 'modify' && user.userStatus == 0}">checked="checked"</c:if>>
                        <label for="userStatus-1">禁用</label>
                    </div>
                    <div class="radio-box">
                        <input name="status" type="radio" id="userStatus_1" value="1"
                               <c:if test="${op == 'modify' && user.userStatus == 1}">checked="checked"</c:if>>
                        <label for="userStatus-2">启用</label>
                    </div>
                </div>
            </div>
        </c:if>
        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                <button class="btn btn-success radius" type="submit"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
            </div>
        </div>
    </form>
</article>
</body>
</html>
