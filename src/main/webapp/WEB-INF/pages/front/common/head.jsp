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
	<link rel="stylesheet" href="../front/css/global.css" type="text/css">
    <link rel="stylesheet" href="../front/css/head.css" type="text/css">
    <link rel="stylesheet" href="../front/css/headFooter.css" type="text/css">
    <link rel="stylesheet" href="../front/css/index_1.css" type="text/css">
	<link rel="stylesheet" href="../front/css/login.css" type="text/css">
  <head>
  </head>
  
  <body>
    <div class="wrapLogin">
    <div class="login">    
    	<div class="time fl" id="showtime"><!--<span>2016-12-24 15:14:34</span><span>星期六</span>--></div>
    <c:if test="${empty sessionScope.user}">
        <div class="register fr"><span>注册</span> <span>登录</span></div>
    </c:if>
     <c:if test="${ not empty sessionScope.user}">
        <div class="register fr"><div class="photo"><a>${sessionScope.user.userName},欢迎您！</a><div class="test"><img src="../front/images/paidapaida.jpg"/>
        <div class="space" style="height:90px;width: 117px;background: url('../front/images/joinSpace.png') no-repeat center;"><ul><li><a style="margin:3px 0px 4px 4px">职位管理</a></li><li><a style="margin:3px 0px 4px 4px" id="frontloginout">退出登录</a></li></ul></div>
        </div>
        </div></div>
    </c:if>
        
    </div>
</div>
<div class="entry" style="display:none">
    <div class="title">
        <div class="close"></div>
    </div>
    <div class="userMes">
        <p><input type="text" value="用户名" id="user" onfocus="if(this.value=='用户名'){this.value='';}" onblur="if(this.value==''){this.value='用户名';}" ></p>
        <p><input type="password"  id="pwd" value="000000" onfocus="if(this.value=='000000'){this.value='';}" onblur="if(this.value==''){this.value='000000';}"></p>
        <p class="code"><input type="text" value="验证码" onfocus="if(this.value=='验证码'){this.value='';}" onblur="if(this.value==''){this.value='验证码';}"><span><img src="../front/images/code.jpg" alt=""></span></p>
        <p class="rlPwd"><span><input type="checkbox">记住密码</span><a class="errormsg" style="padding-left:60px;color:red"></a></p>
        <input type="button" id= "frontlogin" value="登录">
    </div>
</div>
<div class="marker"></div>
<div class="head">
    <div class="logo">
        <a href="<%=basePath%>index/main.do"><img src="../front/images/148904794186891b.png" alt=""></a>
    </div>
<div class="nav">
    <ul id="plane">
        <li style="width:120px"><a href="<%=basePath%>index/main.do"  id="index">首页</a></li>
        <li style="width:120px"><a href="<%=basePath%>index/tonewsmain.do" id = "news">新闻咨询</a></li>
        <li style="width:120px"><a href="<%=basePath%>index/tojobmain.do">找工作</a>
            <!-- <ul style="width: 180px;height: 200px;">
                <li class="cur"><a href="f_1提问365.html">下拉导航一</a></li>
                <li><a href="">下拉导航二</a></li>
            </ul> -->
        </li>
        <li style="width:120px"><a href="b_1教育信息化.html">导航二</a></li>
        <li style="width:120px"><a href="b_1教育信息化.html">导航二</a></li>
        <li style="width:120px"><a href="b_1教育信息化.html">导航二</a></li>
    </ul>
</div>
    <img src="" alt="" class="wenzi">
    <div class="search">
        <input type="text" value="请输入关键字" id="search">
        <img src="../front/images/search.png" alt="">
    </div>
</div>
  </body>
  	<script type="text/javascript" src="../front/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="../front/js/banner.js"></script>
	<script type="text/javascript" src="../front/js/tabs.js"></script>
	<script type="text/javascript" src="../front/js/jquery.slide.js"></script>
  <script type="text/javascript">
  $(document).ready(function () {
  		$(".login span").click(function(){
			$(this).addClass("select").siblings().removeClass("select");
			if($(this).text()=="登录"){
				$(".entry").show();
				$(".marker").show();
			}else if($(this).text()=="注册"){
				window.location.href="<%=basePath%>index/toregister.do";
			}
		});
		$(".close").click(function(){
    		if($(this)){
    			$(".entry").hide();
    			$(".marker").hide();
    		}
    	})
  		$("#frontloginout").click(function(){
    		$.ajax({
    			url:'/job365/index/loginout.do',
				dataType:'json',
				data:{},
				type:'POST',
				async:false,
				success:function(data){
				   if(data.status==true){
				   		location.reload(true);  
				   }else if(data.status==false){
				   		
				   }
				}
    		})
    	})
    	$("#frontlogin").click(function(){
    		var url = "<%=basePath%>index/frontlogin.do";
    		var uname = $("#user").val();
    		var pwd = $("#pwd").val();
    		if(uname==''||pwd==''||uname=='用户名'){
    			$(".errormsg").html("用户名或密码不能为空！");
    			setTimeout(function () { $(".errormsg").empty(); $(".errormsg").hide();}, 5000);
    			return;
    		}
    		$.ajax({
    			url:'/job365/index/frontlogin.do',
				dataType:'json',
				data:{"username":uname,"password":pwd},
				type:'POST',
				async:false,
				success:function(data){
				   if(data.status==true){
				   		location.reload(true);  
				   }else if(data.status==false){
				   		$(".errormsg").html(data.msg);
    					setTimeout(function () { $(".errormsg").empty(); $(".errormsg").hide();}, 5000);
				   }
				}
    		})
    	});
    })
    function showTime(){
        var show_day=new Array('星期一','星期二','星期三','星期四','星期五','星期六','星期日');
        var time=new Date();
        var year=time.getFullYear();
        var month=time.getMonth()+1;
        var date=time.getDate();
        var day=time.getDay();
        var hour=time.getHours();
        var minutes=time.getMinutes();
        var second=time.getSeconds();
        hour<10?hour='0'+hour:hour;
        minutes<10?minutes='0'+minutes:minutes;
        second<10?second='0'+second:second;
        $("#showtime").html("<span>"+year+"-"+month+"-"+date+"&nbsp;&nbsp;&nbsp;"+hour+":"+minutes+":"+second+"  &nbsp;&nbsp;  "+show_day[day-1]+"</span>");
        setTimeout("showTime();",1000);
    }
    showTime();
  </script>

</html>
