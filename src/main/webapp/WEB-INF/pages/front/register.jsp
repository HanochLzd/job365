<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>注册</title>
    <link rel="stylesheet" href="../front/css/global.css" type="text/css">
    <link rel="stylesheet" href="../front/css/register.css" type="text/css">
</head>
<body>
<div class="regBg">
    <img src="../front/images/backgroudimg.png" alt="">
</div>
<div class="head"><img src="../front/images/148904794186891b.png" alt=""></div>
<div class="wrapCon">
    <div class="title"><h3>用户注册</h3></div>
    <div class="register">
        <div class="regNav">
        </div>
        <div class="regBox normal" style="display: block">
        	<p><span class="name"></span>
                <a class="tag" style="margin-left:-105px"><input type="radio" name="teacher" id="teacher"/>
                <label for="teacher" class="usertype">普通用户</label></a>
                <a class="tag"><input type="radio" name="student" id="student"/>
                <label for="student" class="usertype">企业用户</label></a>
            </p>
            <p><input type="text" id="username" placeholder="请输入用户名"><span class="tips success">以字母开始，可用数字、下划线，6—18个字符</span></p>
            <p><input type="password" name="password" id="pwd" placeholder="请输入密码"><span class="tips error">请输入6-16个字符，区分大小写</span></p>
            <div class="stroPwd">
                <div class="strength"><label>密码安全程度：</label> <span class="level" id="weak">一般</span> <span class="level" id="middle"></span> <span class="level" id="strength"></span></div>
                <div class="len_box">
                    <div class="len_color"></div>
                </div>
            </div>
            <p><input type="password" id="pwdonce" placeholder="再次输入密码"><span class="tips">再次输入确认密码</span></p>
            <p><input type="text" id="email" placeholder="请输入邮箱"><span class="tips"></span></p>
			<p><input type="text" id="phone" placeholder="请输入手机号"><span class="tips"></span></p>
            <p class="btn"><input type="button" value="立即注册" class="regBtn1" id = "rnregister"><input type="button" value="取消注册" class="cnacel"></p>
            <p class="speTips"><span class="tips">注意：仅限智商高的人注册！</span></p>
        </div>
    </div>
</div>
<div class="footer">
    <p> 联系电话：********* Email：*************　QQ群:*********</p>
    <p>豫ICP备08000920号</p>
</div>
<script src="../front/js/jquery-1.11.3.min.js"></script>
<script src="../front/js/tabs.js"></script>
<script>
    $(function () {
        $('label').click(function () {
            var radioId = $(this).attr('name');
            $('label').removeAttr('class') && $(this).attr('class', 'checked');
            $('input[type="radio"]').removeAttr('checked') && $('#' + radioId).attr('checked', 'checked');
        });
		
		$(':input').click(function () {
			$(':input').removeAttr("style")
			$(this).css({"border-color":"#aaaaff"});
        });

		$(".cnacel").click(function () {
            window.location.href="<%=basePath%>index/main.do";
        });
        var usertype='';
        $(".regBox .tag").click(function(){
			if($(this).children("label").text()=="普通用户"){
				usertype=1;
			}
			if($(this).children("label").text()=="企业用户"){
				usertype=2;
			}
    	});
        $("#rnregister").click(function () {
            var uname = $("#username").val();
            var pwd = $("#pwd").val();
            var pwdonce = $("#pwdonce").val();
            var email = $("#email").val();
            var phone = $("#phone").val();
            if(!/^[a-zA-Z_][a-zA-Z_0-9]{6,18}$/.test(uname)){
					alert("用户名不符合规则！");
					return;
				}
				if(!/^[\s\S]{6,16}$/.test(pwd)){
					alert("密码不符合规则！");
					return;
				}
				if(uname==''){
					alert("用户名不允许为空！");
					return;					
				}
				if(pwd!=pwdonce){
					alert("两次密码不一致！");
					return;
				}
				if(email==''){
					alert("邮箱不允许为空！");
					return;
				}
				if(email!=""){
        			var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
	     			isok= reg.test(email );
	       			if (!isok) {
						alert("邮箱格式不正确！");
						return;
	        		}
	        	}
	        	if(usertype==''){
	        		alert('请选择用户类型');
	        		return;
	        	}
	        	$.ajax({
	        		type: "get",
	    			url: "/job365/index/register.do",
	    			dataType: "json",
	    			data:{"name":uname,"password":pwd,"email":email,"phone":phone,"usertype":usertype},
					async:false,
	    			success: function(data){
	    					if(data.status==true){
	    						alert('注册成功！');
	    						window.location.href ="<%=basePath%>index/main.do";
	    					}else if(data.status==false){
	    						alert(data.msg);
	    					};
	    			}
	        	});
        });
        /*分类切换*/
        $(".nomalReg").click(function () {
            $(this).css({"background": "url('../images/regBg_1.png') no-repeat 0 0", "color": "#fff"});
            $(".phoneReg").css({"background": "url('../images/regBg2.png') no-repeat 0 -40px", "color": "#3a3a3a"});
            $(".normal").show();
            $(".phone").hide();
        });
        $(".phoneReg").click(function () {
            $(this).css({"background": "url('../images/regBg2.png') no-repeat 0 0", "color": "#fff"});
            $(".nomalReg").css({"background": "url('../images/regBg_1.png') no-repeat 0 -40px", "color": "#3a3a3a"});
            $(".normal").hide();
            $(".phone").show();
        });

      /*密码强度*/
        $("#pwd").keyup(function(){
            AuthPasswd(this.value.trim())
        });
        function AuthPasswd(string) {
            if(string.length >=5) {
                if(/[a-zA-Z]+/.test(string) && /[0-9]+/.test(string) && /\W+\D+/.test(string)) {
                    noticeAssign(1);
                }else if(/[a-zA-Z]+/.test(string) || /[0-9]+/.test(string) || /\W+\D+/.test(string)) {
                    if(/[a-zA-Z]+/.test(string) && /[0-9]+/.test(string)) {
                        noticeAssign(-1);
                    }else if(/\[a-zA-Z]+/.test(string) && /\W+\D+/.test(string)) {
                        noticeAssign(-1);
                    }else if(/[0-9]+/.test(string) && /\W+\D+/.test(string)) {
                        noticeAssign(-1);
                    }else{
                        noticeAssign(0);
                    }
                }
            }else{
                noticeAssign(null);
            }
        }
        function noticeAssign(num) {
            if(num == 1) {
                $('#strength').html('强');
                $('#middle').html('');
                $('#weak').html('');
                $(".len_color").css({"width":"150px","background":"#6F3"});
            }else if(num == -1){
                $('#weak').html('');
                $('#middle').html('中');
                $('#strength').html('');
                $(".len_color").css({"width":"100px","background":"#F90"});
            }else if(num ==0) {
                $('#weak').html('一般');
                $('#middle').html('');
                $('#strength').html('');
                $(".len_color").css({"width":"50px","background":"#F00"});
            }else{
                $('#weak').html(' ');
                $('#middle').html(' ');
                $('#strength').html(' ');
            }
        }
    });
</script>
</body>
</html>
