<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'scenery_add.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<script type="text/javascript">
 $(function(){
	var op = "${op}";
	document.getElementById("count").innerHTML = "${doc.resumeDesc}".length.toString(); 
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	$("#form-doc-add").validate({
	
		rules:{
				resumeUrl:{
					required:true,
				}
			},
		
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			$.post('<%=basePath%>uploadResume/saveDoc.do',$(form).serialize(),function(data) {
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

function doUpload(){
var flag = check();
    if(flag == false){
       return;
    }
	var formData = new FormData($("#form-doc-add")[0]);
	var file = $("input[name='resumeUrl']").val();
	//alert(file);
	if(""==file){
		layer.alert("请选择简历 文件！",{icon: 6,time:0});
		return false;
	}
	$.ajax({
		url:"<%=basePath%>uploadResume/saveDoc.do",
		type:"POST",
		data:formData,
		astnc:false,
		cache:false,
		contentType:false,
		processData:false,
		success: function (data){
			var jsonReturn = eval("("+data+")");
			layer.alert(jsonReturn.msg, {icon: 6,time:0}, function(data){
    			var index = parent.layer.getFrameIndex(window.name);
			    window.parent.location.reload(true);
				parent.layer.close(index);
				});
		},
		error: function (jsonReturn){
			layer.alert(jsonReturn.msg, {icon: 5,time:0}, function(data){
    			var index = parent.layer.getFrameIndex(window.name);
			    window.parent.location.reload(true);
				parent.layer.close(index);
				});
		}
		
	})
}
function check() {
      //检验导入的文件是否为Excel文件  
      var docPath = document.getElementById("doc").value;
      
      if(docPath == null || docPath == ''){
        layer.alert("请选择要导入的简历 文件");
          return false;
      }else{
        var fileExtend = docPath.substring(docPath.lastIndexOf('.')).toLowerCase();
          if (fileExtend == ".docx"||fileExtend == ".doc"||fileExtend == ".exl"){
            return true;  
          }else{
         	 layer.alert("格式必须为.doc，.docx，.exl格式的简历 文件");
          	 return false;
          }
      }
    }
function checkLen(obj) { 

	var maxChars = 200;//最多字符数 

	if (obj.value.length > maxChars) obj.value = obj.value.substring(0,maxChars); 

	var curr = obj.value.length; 

	document.getElementById("count").innerHTML = curr.toString(); 

	} 
</script>
  </head>
  
  <body>
<article class="page-container">
	<form action="" enctype="multipart/form-data"  method="post" class="form form-horizontal" id="form-doc-add">
	<input type="hidden" id="op" name="op" value="${op}">
	<input type="hidden" id="id" name="id" value="${doc.id}">
		
		
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">简历上传：</label>
			<div class="formControls col-xs-8 col-sm-9">
					<input type="file"  class="input-text" value="${doc.resumeUrl }"  name="resumeUrl" id="doc"  />
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">简历简介：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<textarea  name="docDesc" cols="" rows="" class="textarea"
					placeholder="用200字以内的一段文字描述一下本简历 ..." onkeyup="checkLen(this)">${doc.resumeDesc }</textarea>
				<p class="textarea-numberbar"><em class="textarea-length"><span id="count">200</span></em>/200</p>
			</div>
		</div>
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
				<input class="btn btn-success radius" value="保存" type="button" onclick="doUpload()"/>
			</div>
		</div>
	</form>
</article>
</body>
</html>
