<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>图片管理</title>
<script type="text/javascript">
	//样式
	$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	var op = "${op}";
	/* if(op == "modify"){
		var content = "${active.content}";
		$("textarea[name = 'bianjineirong']").val(content);
	}
	var ue = UE.ui.Editor().render("editor"); */
	
	//图片信息添加
		$("#form-article-add").validate({
			rules:{
				imageName:{
					required:true,
				},
				content:{
					required:false,
				}
			},
			onkeyup:false,
			focusCleanup:true,
			success:"valid",
			submitHandler:function(form){
			/* var shuruneirong = UE.getEditor("editor").getContent(); 
			$("input[name = 'content']").val(shuruneirong);*/
				$.post('<%=basePath%>moduleImage/saveModuleImage.do',$(form).serialize(),function(data) {
				    var jsonReturn = eval("(" + data +")");
					layer.alert(jsonReturn.msg);
					if(jsonReturn.code == 1){
						 /* var current_frameId = "module_image_add";
						 if(op == "modify"){
							 current_frameId = "active_edit_"+$("#id").val();
						 } */
				         var index = parent.layer.getFrameIndex(window.name);
				         window.parent.location.reload(true);
					     parent.layer.close(index);
					     //reloadIframeById("<%=basePath%>moduleImage/getImageList.do","校友风采维护","moduleImage_getImageList_do",current_frameId);
				     
			    	}				   
				});							
			}
		});
	
	});


	
	function upload_img(){
		var pid="${pid}";
		var url = "<%=basePath%>moduleImage/imageUploadInit.do?imageNum=1&pid="+pid;
		layer_show('图片上传', url, '', '680');
	
	}
	
	function set_img_url(obj){
		$(obj).each(function(){
  		    $("#imageUrl").val(this.savePath);
	  		$("#new_picture").show();
	  		$("#new_picture").attr("src","<%=basePath%>"+this.savePath);
  	  	});
		
	}
		
</script>

</head>
<body>
	<div class="page-container">
	<form action="" method="post" class="form form-horizontal" id="form-article-add">
		<input type = "hidden" name="op" id="op" value="${op }"/>
		<input type = "hidden" name="pid" id="pid" value="${pid }"/>
		<c:if test="${op =='modify' }">
		<input type="hidden" name="id" id="id" value="${moduleImage.id }">
		</c:if>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>图片名称：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${moduleImage.imageName}" placeholder="" id="imageName" name="imageName">
			</div>
		</div>

		<c:if test="${op=='modify'}">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>图片：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<img alt="" src="<%=basePath%>${moduleImage.imageUrl}" id="new_picture" width="200" height="200" border="0">
			</div>
		</div>
		</c:if>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>
				<input type="button" class="btn btn-success" value="上传图片" onclick="upload_img()"/>
			</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="hidden" class="input-text"  id="imageUrl" name="imageUrl" value="${moduleImage.imageUrl}">
				<c:if test="${op=='add'}">
				 <img id="new_picture" width="200" height="200" border="0" style="display:none"/>
				 </c:if>
			</div>
		</div>
			
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">备注：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<textarea name="remark" cols="" rows="" class="textarea"  placeholder="备注">${moduleImage.remark }</textarea> 
			</div>
		</div>		
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
				<button class="btn btn-success radius" type="submit"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
				<!-- <button onClick="article_save();" class="btn btn-secondary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存草稿</button> -->
				<!-- <button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button> -->
			</div>
		</div>
		
	</form>
</div>

</body>
</html>