<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="../common/taglibs.jsp" %>
<html >
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title>部门管理</title>

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript">
	$(function(){
	
	   /*回显门户显示的模块信息*/
	    $.getJSON('<%=basePath%>doorManage/getModelIds.do',function(modelIds){
	        
	      var length = modelIds.length;
	      for(var i=0; i<length; i++) {
	        $("input[value="+modelIds[i]+"]").attr("checked",true);
	      }
	         
	    });
	    
	
	    $("#modelForm").submit(function(){
	
			var url = "<%=basePath%>doorManage/modelSave.do";
			layer.alert($("#modelForm").serialize());			 
		    $.post(url,$("#modelForm").serialize(),function(data){
		    
				var index = parent.layer.getFrameIndex(window.name);
				parent.layer.close(index);
		    });			
			
		   return false;
		 });
	 
		
	});
</script>
<!--/请在上方写此页面业务相关的脚本-->

</head>
<body >
	<article class="page-container">
	<form action="" id="modelForm">
		<dl class="permission-list">
		    
			<dd>
			    <input type="hidden" name="modelId">
				<label class=""> <input type="checkbox" value="1"
					name="modelId" id="news"> 新闻聚焦
				</label> <label class=""> <input type="checkbox" value="2"
					name="modelId" id="advice"> 通知公告
				</label> <label class=""> <input type="checkbox" value="3"
					name="modelId" id="donate"> 校友风采
				</label> <label class=""> <input type="checkbox" value="4"
					name="modelId" id="action"> 校友捐赠
				</label> </label> <label class=""> <input type="checkbox" value="5"
					name="modelId" id="active"> 校友活动
				</label>
			</dd>
		</dl>
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3"style="margin-top:10px;position:relative;float:right;">
				<button type="submit" class="btn btn-success radius" id="model-save"style="margin-top:10px;margin-left:10px;width:100px;"><i class="icon-ok"></i>保存</button>
			</div>
		</div>
	</form>	
	</article>
</body>
</html>