<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp" %>
<html>
<head>
<title>图片列表</title>

<script type="text/javascript">
	var pid=${pid};
	function get_checked_row_num(){
		return $("input[name='imageId']:checked").length;
	}

	function delImage(){
	var ids = "";
	$("input[name='imageId']:checked").each(function(){
			ids = ids + $(this).val()+",";
		});		
	 if(get_checked_row_num()<=0){
	 	
			        layer.msg("请选择一张照片!", {icon:1, time:1000});
			    }else{
			    	 layer.confirm('确认要删除吗？',function(index){
						var src="<%=basePath%>moduleImage/delHistoryImage.do?&ids="+ids;
						$.post(src,function(data){
						var jsonReturn = eval("(" + data +")");
							if(jsonReturn.code=="1"){
								layer.msg(jsonReturn.msg, {icon:6, time:1000});								
					       		location.reload(true);
							}else{
								layer.msg(jsonReturn.msg, {icon:5, time:1000});
								location.reload(true);
							}
							
						});
					
					}); 
			    }
		//window.location.href="<%=basePath%>moduleImage/delHistoryImage.do?&id="+imageId;
		 
	}
	
	function showImage(imageId){
		//window.location.href="<%=basePath%>moduleImage/showImage.do?&id="+imageId;
		
		var url = "<%=basePath%>moduleImage/showImage.do?&id="+imageId;
			layer_show('图片展示',url,'','500');
	}
	function fenyeo(currentPage){
		window.location.href="<%=basePath%>moduleImage/historyShow.do?&currentPage="+currentPage+"&pid="+pid;
	}
	function fenyet(currentPage){
		window.location.href="<%=basePath%>moduleImage/historyShow.do?&currentPage="+currentPage+"&pid="+pid;
	}
	function fenyes(currentPage){
		window.location.href="<%=basePath%>moduleImage/historyShow.do?pid="+pid;
	}
	function fenyef(currentPage){
		window.location.href="<%=basePath%>moduleImage/historyShow.do?&currentPage="+currentPage+"&pid="+pid;
	}
</script>
</head>
<body>
	<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 图片管理 <span class="c-gray en">&gt;</span> 图片记录 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"> <!-- <a href="javascript:;" onclick="edit()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe6df;</i> 编辑</a> -->  <a href="javascript:;" onclick="delImage()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> </span> <span class="r">共有图片：<strong>${imageUrlList.size()}</strong> 张</span> </div>
	<div class="portfolio-content">
		<input type="hidden" id="pid" name="pid" value="${pid }">
		<table style="border-collapse: separate;border-spacing:40px;">
			<c:if test="${empty imageUrlList}">
	        <tr>
	          <td colspan="8">还没有图片记录呦！</td>
	        </tr>
	     	</c:if>
	     	
	     	<c:if test="${!empty imageUrlList}">
			<c:forEach items="${imageUrlList}" var="image" varStatus="status">
			<c:if test="${status.index%6==0 }"><tr></c:if>
			<td>
				<div class="portfoliobox">
				<input class="checkbox" id="id" name="imageId" type="checkbox" value="${image.id }">
				<a onclick="showImage('${image.id}')"><img alt="" src="<%=basePath%>${image.imageUrl}" width="200" height="200" border="0"></a>
				</div>
			</td>			
			<c:if test="${status.index%6==5 }"><tr/></c:if>
		</c:forEach>
		</c:if>
		</table>		

	</div>
</div>
<c:if test="${!empty imageUrlList}">
<div style="text-align:center" class="c-gray en">
	共找到   ${num } 张，当前第${currentPage}    页，
	<a onclick="fenyes()">首页</a>

	<c:if test="${currentPage!=1}"><a onclick="fenyet('${currentPage-1}')">上一页</a></c:if>
	
	<c:if test="${currentPage!=totalPage}"><a onclick="fenyeo('${currentPage+1}')">下一页</a></c:if>
	<a onclick="fenyef(${totalPage})">尾页</a>
	
	</div>
	</c:if>
</body>
</html>