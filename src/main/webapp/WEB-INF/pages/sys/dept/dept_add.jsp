<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp" %>
<html>
<head>
<title>部门管理</title>

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript">
	$(function(){
		document.getElementById("count").innerHTML = "${sysDept.orgDescription}".length.toString();
		
		$('.skin-minimal input').iCheck({
			checkboxClass: 'icheckbox-blue',
			radioClass: 'iradio-blue',
			increaseArea: '20%'
		});
		//部门添加
		$("#form-admin-dept-add").validate({
			rules:{
				orgName:{
					required:true,
				},
				orgCode:{
					required:true,
				},
				orgLeader:{
					required:true,
				},
				orgContact:{
					required:true,
					isTel:true,
				},
				orgType:{
					required:true,
				},
				orgDescription:{
					required:false,
				},
			},
			onkeyup:false,
			focusCleanup:true,
			success:"valid",
			submitHandler:function(form){
				$.post('<%=basePath%>dept/saveDept.do',$(form).serialize(),function(data) {
				   var jsonReturn = eval("(" + data +")");
					if(jsonReturn.code == 1){
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
	
	
	function checkLen(obj) { 

	var maxChars = 100;//最多字符数 

	if (obj.value.length > maxChars) obj.value = obj.value.substring(0,maxChars); 

	var curr = obj.value.length; 

	document.getElementById("count").innerHTML = curr.toString(); 

	}
</script>
<!--/请在上方写此页面业务相关的脚本-->

</head>
<body>
	<article class="page-container">
		<form action="" method="post" class="form form-horizontal" id="form-admin-dept-add">
			<input type = "hidden" name="op" id="op" value="${op }"/>
			<c:if test="${op=='modify'}">
			<input type = "hidden" name="id" id="id" value="${sysDept.id }"/>
			</c:if>
			<input name="menuId" type="hidden">
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>组织名称：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" value="${sysDept.orgName }" placeholder="" id="orgName" name="orgName">
				</div>
			</div>
			
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>组织代码：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" value="${sysDept.orgCode }" placeholder="" id="orgCode" name="orgCode">
				</div>
			</div>
			
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>组织负责人：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" value="${sysDept.orgLeader }" placeholder="" id="orgLeader" name="orgLeader">
				</div>
			</div>
			
			
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>组织联系方式：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" value="${sysDept.orgContact }" placeholder="" id="orgContact" name="orgContact">
				</div>
			</div>
			
			<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>组织类型：</label>
			<div class="formControls col-xs-8 col-sm-9 skin-minimal">
				<div class="radio-box">
					<input name="orgType" type="radio" id="male" value="0" <c:if test="${op == 'add'}">checked="checked"</c:if> <c:if test="${op == 'modify' && sysDept.orgType == 0}">checked="checked"</c:if>>
					<label for="sex-1">校总会</label>
				</div>
				<div class="radio-box">
					<input name="orgType" type="radio" id="female" value="1" <c:if test="${op == 'modify' && sysDept.orgType == 1}">checked="checked"</c:if>>
					<label for="sex-2">学院分会</label>
				</div>
				<div class="radio-box">
					<input name="orgType" type="radio" id="femal" value="2" <c:if test="${op == 'modify' && sysDept.orgType == 2}">checked="checked"</c:if>>
					<label for="sex-3">地方分会</label>
				</div>
			</div>
		</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3">组织描述：</label>
				<div class="formControls col-xs-8 col-sm-9">
				<textarea name="orgDescription" cols="" rows="" class="textarea"  placeholder="组织描述" onkeyup="checkLen(this)">${sysDept.orgDescription }</textarea>
				 <p class="textarea-numberbar"><em class="textarea-length"><span id="count">100</span></em>/100</p>
					
				</div>	
			</div>
			
			<c:if test="${op == 'modify'}">
		      <div class="row cl">
			       <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>状态：</label>
			       <div class="formControls col-xs-8 col-sm-9 skin-minimal">
				        <div class="radio-box">
					         <input name="orgStatus" type="radio" id="userStatus_0" value="0" <c:if test="${op == 'add'}">checked="checked"</c:if> <c:if test="${op == 'modify' && sysDept.orgStatus == 0}">checked="checked"</c:if>>
					         <label for="userStatus-1">禁用</label>
				        </div>
				        <div class="radio-box">
					         <input name="orgStatus" type="radio" id="userStatus_1" value="1" <c:if test="${op == 'modify' && sysDept.orgStatus == 1}">checked="checked"</c:if>>
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