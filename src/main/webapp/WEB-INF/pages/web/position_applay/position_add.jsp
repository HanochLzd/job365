<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'companyinfo_add.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="<%=uiPath%>common/lib/ueditor/utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/ueditor/utf8-jsp/ueditor.all.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	var op = "${op}";
	//实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');
	/* var ue = UE.ui.Editor().render("editor"); */
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	$("#form-positioninfo-add").validate({	
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			console.log($(form).serialize())
			alert($("#positionSalary").val())
			$.ajax({
				type:"post",
				url:"<%=basePath%>position/save.do",
				data:$(form).serialize(),
				dataType:"json",
				success:function(data){
					//var jsonReturn = eval("("+data+")");
				    if(data.code == 1){
				         layer.alert(data.msg, {icon: 6,time:0}, function(data){
					    			var index = parent.layer.getFrameIndex(window.name);
								    window.parent.location.reload(true);
									parent.layer.close(index);
									});
				    }
				},
				error:function(data){
					alert(44)
				}
			})
			
		}
		
	});
	
});
	
		
	

</script> 
  </head>
  
  <body>
<article class="page-container">
	<form method="post" class="form form-horizontal" id="form-positioninfo-add">
	   
	  <input  name="id"  type="hidden" value="${position.id }">
	  <input name = "op" type="hidden" value="${op}"/>
	   
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>职位名称：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${position.positionName}" placeholder="" id="positionName" name="positionName" >
			</div>
		</div>
		
		
		
		     <div class="row cl">
			      <label class="form-label col-xs-4 col-sm-2">职位薪资：</label>
			      <div class="formControls col-xs-8 col-sm-9"> 
			           <span class="select-box">
				           <select class="select" id="positionSalary" name="positionSalary">
				           <c:if test="${!empty position }">
	                                       <option value="${position.positionSalary }">${position.positionSalary }</option>
	                                 </c:if>
				           					               
	                           <c:forEach items="${baseList }" var="base">
	    				             <option value="${base.codeName }">${base.codeName}</option>
	    		               </c:forEach>
				           </select>
				       </span>
		         </div>
		   </div>
		
		
		
		
		
		
					
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">职位要求：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${position.positionRequire}" placeholder="" id="positionRequire" name="positionRequire" >
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">联系电话：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${position.positionPhone}" placeholder="" id="positionPhone" name="positionPhone" >
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">工作地点：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${position.positionAddress}" placeholder="" id="positionAddress" name="positionAddress" >
			</div>
		</div>
		
		
		
		
		
		
	
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">职位描述：</label>
			<div class="formControls col-xs-8 col-sm-9"> 
				<!--<textarea id="editor" name="bianjineirong" type="text/plain" >请于此编辑您的资讯信息...</textarea>  -->
				<textarea id="editor" type="text/plain" name="positionDesc" style="width:100%;height:500px;">${position.positionDesc}</textarea>
			</div>
		</div>
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
				<button class="btn btn-success radius" type="submit"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
			</div>
		</div>
	</form>
</article>
</body>
<script type="text/javascript">
</script>
</html>
