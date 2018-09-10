<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp" %>
<%@ page isELIgnored="false"%>
<html >
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title>新建系统权限</title>
</head>
<body>
<article class="page-container">
	<form action="" method="post" class="form form-horizontal" id="form-admin-role-add">
		
		<input type="hidden" class="input-text" value="${menu.menuId }" placeholder="" id="menuId" name="menuId">
		<input type="hidden" class="input-text" value="${op}" placeholder="" id="op" name="op">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>权限名称：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${menu.menuName }" placeholder="" id="menuName" name="menuName">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">权限路径：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${menu.menuUrl }" placeholder="" id="menuUrl" name="menuUrl">
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">权限描述：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${menu.menuDesc }" placeholder="" id="menuDesc" name="menuDesc">
			</div>
		</div>
		
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<button type="submit" class="btn btn-success radius" id="admin-role-save" name="admin-role-save"><i class="icon-ok"></i> 确定</button>
			</div>
		</div>
	</form>
</article>
<script type="text/javascript">
$(function(){
	$(".permission-list dt input:checkbox").click(function(){
		$(this).closest("dl").find("dd input:checkbox").prop("checked",$(this).prop("checked"));
	});
	$(".permission-list2 dd input:checkbox").click(function(){
		var l =$(this).parent().parent().find("input:checked").length;
		var l2=$(this).parents(".permission-list").find(".permission-list2 dd").find("input:checked").length;
		if($(this).prop("checked")){
			$(this).closest("dl").find("dt input:checkbox").prop("checked",true);
			$(this).parents(".permission-list").find("dt").first().find("input:checkbox").prop("checked",true);
		}
		else{
			if(l==0){
				$(this).closest("dl").find("dt input:checkbox").prop("checked",false);
			}
			if(l2==0){
				$(this).parents(".permission-list").find("dt").first().find("input:checkbox").prop("checked",false);
			}
		}
	});
	
	$("#form-admin-role-add").validate({
		rules:{
			roleName:{
				required:true,
			},
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			
			$.post('<%=basePath%>menu/saveMenu.do',$(form).serialize(),function(data) {
				  var json = eval("("+data+")");

				
					layer.alert(json.msg, {icon: 6,time:0}, function(data){
				    			var index = parent.layer.getFrameIndex(window.name);
							    window.parent.location.reload(true);
								parent.layer.close(index); 
				    		
				    	});
				
					/* 				
					if(json.code==1){
						
						layer.alert(json.msg, {icon: 6,time:0}, function(data){
			    			var index = parent.layer.getFrameIndex(window.name);
						    window.parent.location.reload(true);
							parent.layer.close(index); 
			    		
			    	});
						
					} */
					
				
				});
			
			/* $(form).ajaxSubmit();
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index); */
		}
	});
});
</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>