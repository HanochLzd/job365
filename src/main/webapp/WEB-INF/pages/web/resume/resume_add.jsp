<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp"%>
<%@ page isELIgnored="false"%>
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
  $(function(){
	
	document.getElementById("count").innerHTML = "${resume.resumeOthers}".length.toString(); 
	
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	$("#form-resume-add").validate({
		rules:{
			id:{
				required:true,
				number:true
			},
			resumeName:{
				required:true,
				minlength:6,
				maxlength:16
			},
			resumePhone:{
			    required:true,
			    number:true,
			    minlength:7,
			    maxlength:11
			},
			resumeSex:{
				required:true,
			},
			
			resumeEmail:{
				required:true,
				email:true,
			},
			resumeSalary:{
				number:true,
				required:true
			}
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){			
			$.post('<%=basePath%>resume/saveResume.do',$(form).serialize(),function(data) {
			    var jsonReturn = eval('('+data+')');
			   console.log(jsonReturn);
			    if(jsonReturn.code == 0){
			    	layer.alert(jsonReturn.msg, {icon: 6,time:0}, function(data){
			    			var index = parent.layer.getFrameIndex(window.name);
						    window.parent.location.reload(true);
						    parent.layer.close(index); 			    		
			    	});				    	
			    }else{
			    	layer.alert(jsonReturn.msg, {icon: 6,time:0}, function(data){
		    			var index = parent.layer.getFrameIndex(window.name);
					    window.parent.location.reload(true);
					    parent.layer.close(index); 	
			    	});
			    }			   		    			    
			});
		}
	});
	
});
</script> 
  </head>
  
  <body>
<article class="page-container">
	<form action="" method="post" class="form form-horizontal" id="form-resume-add">
	    
	    <input type="hidden" id="op" name="op" value="${op}">
	    <input type="hidden" id="id" name="id" value="${resume.id}">
	    
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>用户名：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${resume.resumeName}" placeholder="" id="resumeName" name="resumeName">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>性别：</label>
			<div class="formControls col-xs-8 col-sm-9 skin-minimal">
				<div class="radio-box">
					<input name="resumeSex" type="radio" id="male" value="0" <c:if test="${op == 'add'}">checked="checked"</c:if> <c:if test="${op == 'modify' && resume.resumeSex == 0}">checked="checked"</c:if>>
					<label for="sex-1">男</label>
				</div>
				<div class="radio-box">
					<input name="resumeSex" type="radio" id="female" value="1" <c:if test="${op == 'modify' && resume.resumeSex == 1}">checked="checked"</c:if>>
					<label for="sex-2">女</label>
				</div>
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>电话：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" placeholder="输入正确的联系方式如：18036374809" value="${resume.resumePhone}" name="resumePhone" id="resumePhone">
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>邮箱：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" placeholder="*******@163.com" value="${resume.resumeEmail}" name="resumeEmail" id="resumeEmail">
			</div>
		</div>						
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red"></span>期望工作地址：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" placeholder="" value="${resume.resumeWorkplace}" name="resumeWorkplace" id="resumeWorkplace">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red"></span>期望职位：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" placeholder="" value="${resume.resumePosition}" name="resumePosition" id="resumePosition">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red"></span>期望薪资：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" placeholder="" value="${resume.resumeSalary}" name="resumeSalary" id=resumeSalary>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red"></span>工作经验：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" placeholder="良好的经验有助于找到满意的职位哟！" value="${resume.resumeExperience}" name="resumeExperience" id="resumeExperience">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">备注：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<textarea name="resumeOthers" id="resumeOthers" cols="" rows="" class="textarea"  placeholder="说点什么..." onkeyup="checkLen(this)" >${resume.resumeOthers }</textarea>
				<p class="textarea-numberbar"><em class="textarea-length"><span id="count">100</span></em>/100</p>
			</div>
		</div>
		<c:if test="${op == 'modify'}">
		      <div class="row cl">
			       <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>状态：</label>
			       <div class="formControls col-xs-8 col-sm-9 skin-minimal">
				        <div class="radio-box">
					         <input name="resumeStatus" type="radio" id="resumeStatus_0" value="0" <c:if test="${op == 'add'}">checked="checked"</c:if> <c:if test="${op == 'modify' && resume.resumeStatus == 0}">checked="checked"</c:if>>
					         <label for="resumeStatus-1">禁用</label>
				        </div>
				        <div class="radio-box">
					         <input name="resumeStatus" type="radio" id="resumeStatus_1" value="1" <c:if test="${op == 'modify' && resume.resumeStatus == 1}">checked="checked"</c:if>>
					         <label for="resumeStatus-2">启用</label>
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
