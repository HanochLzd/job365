<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/taglibs.jsp" %>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title>校友信息管理系统</title>
   <script type="text/javascript">
   $(function(){
	 var flag= true;
	 $("#change-pwd-form").submit(function(){
		if(flag){
		 	var url = "<%=basePath%>login/savePwd.do";
			$.post(url,$("#change-pwd-form").serialize(),function(data){
				   var jsonReturn = eval("(" + data +")");				  
	   			   if(jsonReturn.code == "1"){	
	   			   		layer.alert(jsonReturn.msg, {icon: 6,time:0}, function(data){
	   			   		logout();
	   			   		});
		   								
	   			   }else{
	   			   		layer.alert(jsonReturn.msg, {icon: 6,time:0}, function(data){
		   			   		logout();
		   			   		});
	   			   }
			   });			
		} 
	   return false;
	 });
     
   });
   
   function logout(){
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
		top.location.href = "<%=basePath%>login/init.do";
   }
   </script>
</head>
<body>
<article class="page-container">
    <form class="form form-horizontal" action="#" id="change-pwd-form" method="post" style="padding:10px;">
      <div class="row cl" style="margin-left:150px;margin-top:20px;">
        <div class="formControls col-xs-8">
          <input id="pwd1" name="pwd1" type="password" placeholder="输入原始密码" class="input-text size-L">
        </div>
      </div>
      <div class="row cl" style="margin-left:150px;margin-top:20px;">
        <div class="formControls col-xs-8">
          <input id="pwd2" name="pwd2" type="password" placeholder="输入修改密码" class="input-text size-L">
        </div>
      </div>
      <div class="row cl" style="margin-left:150px;margin-top:20px;">
        <div class="formControls col-xs-8">
          <input id="pwd3" name="pwd3" type="password" placeholder="再次输入修改密码" class="input-text size-L">
        </div>
      </div>
      <div class="row cl"style="margin-left:50px;margin-top:40px;">
        <div class="formControls col-xs-8 col-xs-offset-3">
          <input name="" type="submit" class="btn btn-success radius size-L" value="&nbsp;保&nbsp;&nbsp;&nbsp;&nbsp;存&nbsp;">
          <input name="" type="reset" class="btn btn-default radius size-L" value="&nbsp;取&nbsp;&nbsp;&nbsp;&nbsp;消&nbsp;">
        </div>
      </div>
    </form>
</article>
</body>
</html>