<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'newsinfo_add.jsp' starting page</title>
    
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
	
	$("#form-newsinfo-add").validate({
		
		rules:{
			newsTitle:{
				required:true,
			}
		},
		
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			$.post('<%=basePath%>news/saveNews.do',$(form).serialize(),function(data) {
			    var jsonReturn = eval("("+data+")");
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
	function upload_img(){
		var url = "<%=basePath%>common/upload/imageUploadInit.do?imageNum=1&pid=2";
		layer_show('图片上传', url, '', '500');
	
	}
	
	function set_img_url(obj){
		$(obj).each(function(){
  		    $("#pictureUrl").val(this.savePath);
	  		$("#new_picture").show();
	  		$("#new_picture").attr("src","<%=basePath%>"+this.savePath);
  	  	});
		
	}

</script> 
  </head>
  
  <body>
<article class="page-container">
	<form action="" method="post" class="form form-horizontal" id="form-newsinfo-add">
	    <input type="hidden" id="id" name="id" value="${news.id}">
	    <input type="hidden" id="op" name="op" value="${op}">
	    <input type="hidden" id="createUserId" name="createUserId" value="${news.createUserId}">
	   
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>资讯标题：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${news.newsTitle}" placeholder="" id="newsTitle" name="newsTitle" >
			</div>
		</div>
		
		<c:if test="${op=='modify'}">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>封面图片：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<img alt="" src="<%=basePath%>${news.imagePath}" id="new_picture" width="200" height="200" border="0">
			</div>
		</div>
		</c:if>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>
				<input type="button" class="btn btn-success" value="上传封面" onclick="upload_img()">
			</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="hidden" class="input-text"  id="pictureUrl" name="imagePath" value="${newsinfo.imagePath}">
				<c:if test="${op=='add'}">
				<img id="new_picture" width="200" height="200" border="0" style="display:none"/>
				</c:if>
			</div>
		</div>
		
		
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">备注：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${news.remark}" placeholder="" id="remark" name="remark" >
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">资讯内容：</label>
			<div class="formControls col-xs-8 col-sm-9"> 
				<!--<textarea id="editor" name="bianjineirong" type="text/plain" >请于此编辑您的资讯信息...</textarea>  -->
				<textarea id="editor" type="text/plain" name="newsContent" style="width:100%;height:500px;">${news.newsContent}</textarea>
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
