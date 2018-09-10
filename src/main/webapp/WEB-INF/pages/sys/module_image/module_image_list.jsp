<%@ page import="java.net.URLDecoder" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>图片信息列表</title>

<script type="text/javascript">
		$(function(){
			f_getList();
		
		});
		var activeList;
		function f_getList(){
				var startDate = $("#logmin").val();
				var endDate = $("#logmax").val();
				var title = $("#title").val();
			  activeList=$("#active_table").dataTable({
						"bServerSide": true,     //是否启动服务器端数据导入
		                "bFilter" : false,       //是否搜索栏
		                "bPaginate": true,       //是否显示分页器
		                "bInfo": true,           //是否显示表格的一些信息
		                "bJQueryUI": false,      //是否启用JQueryUI风格
		                "bLengthChange": true,   //是否显示每页大小的下拉框
		                "sPaginationType": "full_numbers", //分页样式
		                "bDestroy":true,
		                "sServerMethod": "POST",
		                "sAjaxSource" : "<%=basePath%>moduleImage/getImageList.do", //请求数据的URL
		                "bProcessing" : true,	 //DataTables载入数据时，是否显示‘进度’提示
		                "aoColumnDefs": [
		                	{
					           "aTargets" : [0],   //第1列
					           "mData" : "id",     
					           "mRender" : function(a, b, c, d){
					               return '<input type="checkbox" name="dept_list" id="'+ c.id +'" value="'+ c.id +'" >';
					           }			           
					        },
		                			              
		                	{
		                		"aTargets": [1], //第2列
		                		"mData": "imageName",
		                		 "mRender" : function(a, b, c, d){
		      			           return '<u style="cursor:pointer" class="text-primary" onClick="image_show('+c.id+')" title="预览" value="">'+c.imageName+'</u>';
		      			        }
		                	},
		                	{
					           "aTargets" : [2],   //第3列
					           "mData" : "remark"
					        },
		                	
		                	{
					           "aTargets" : [3],   //第4列
					           "mData" : "createDate",
					           "mRender" : function(a, b, c, d){
					           		return '<center>'+a+'</center>';
					           }
					        },
					        {
					           "aTargets" : [4],   //第5列
					           "mRender" : function(a, b, c, d){   
					                return '<center><a title="编辑" href="javascript:;" onclick="image_edit('+c.id+')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;' +
					                    '<a title="删除" href="javascript:;" onclick="image_del(this,'+c.id+')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></center>';
					               
					           }
					        }       
		                	
		                ], 
		                 "fnServerParams" : function(aoData) {
						    aoData.push(
						           { "name" : "startDate", "value" : startDate},   //自定义参数
						           { "name" : "endDate", "value" : endDate},
						           { "name" : "title", "value" : title}
					    );				
				    } 	
					
					});
				}
				
				
				
		//修改
		function image_edit(id){
			var pid=${pid};
			var url="<%=basePath %>moduleImage/toUpdateImage.do?id="+id+"&pid="+pid;	
			/* removeIframeById("active_edit_"+id);
			creatIframe(url,"修改校友风采信息","active_edit_"+id); */
			var index = layer.open({
	    		type : 2,
	    		title : '修改图片信息',
	    		content : url
	  			});
	  			layer.full(index);
		}
		//删除
		function image_del(obj,id){
			layer.confirm('确认要删除吗？',function(index){
						var src="<%=basePath%>moduleImage/delImageById.do?&id="+id;
						$.post(src,function(data){
						var jsonReturn = eval("(" + data +")");
							if(jsonReturn.code=="1"){
								layer.msg(jsonReturn.msg, {icon:6, time:1000});
								activeList.fnDraw(true);
							}else{
								layer.msg(jsonReturn.msg, {icon:5, time:1000});
								activeList.fnDraw(true);
							}
							
						});
					
					});
			
		}
		
	 //获取行数
	 function get_checked_row_num(){
		return $("#active_table tbody tr input[name='dept_list']:checked").length;
				
		}
		//批量删除
	function datadel(){
		var ids = "";
		//遍历选中行
		$("#active_table tbody tr input[name='dept_list']:checked").each(function(){
			ids = ids + $(this).val()+",";
		});	
		 if(get_checked_row_num()<=0){
			        layer.msg("请选择行!", {icon:1, time:1000});
			    }else{
			         layer.confirm('确认要批量删除吗？',function(index){
				       var url = "<%=basePath%>moduleImage/delImageByBatch.do?&ids="+ids;
				        $.post(url, function(data){
				            var jsonReturn = eval("(" + data +")");
				            if(jsonReturn.code=="1"){
				            	layer.msg(jsonReturn.msg, {icon:6, time:1000});
								activeList.fnDraw(true);
								}else{
									layer.msg(jsonReturn.msg, {icon:5, time:1000});
									activeList.fnDraw(true);
								}
				        });
			      });
			    }
	}		
			
		function image_show(id){
			var url = "<%=basePath%>moduleImage/imageShow.do?id="+id;
			layer_show('图片展示',url,'','500');
			/* var index = layer.open({
				type: 2,
				title: '资讯预览',
				content: url
			});
			layer.full(index); */
		}
		
		function history_show(){
			var pid=${pid};
			var url="<%=basePath%>moduleImage/historyShow.do?pid="+pid;
			 var index = layer.open({
			type: 2,
			title: '图片预览',
			content: url
		});
		layer.full(index);
		}
		
		//添加
		function image_add(title,url,id){
			/* //先清除已打开的同一个页面
			removeIframeById("module_image_add");
			creatIframe(url,"添加图片信息","module_image_add"); */
			
			var index = layer.open({
	    		type : 2,
	    		title : '添加图片信息',
	    		content : url+"?"+"pid="+id
	  			});
	  			layer.full(index);
		}
		
		
		//修改
		function picture_edit(title,url,id){
			var index = layer.open({
				type: 2,
				title: title,
				content: url
			});
			layer.full(index);
			
		}
		
		//删除
		function picture_del(obj,id){
			layer.confirm('确认要删除吗？',function(index){
				$(obj).parents("tr").remove();
				layer.msg('已删除!',{icon:1,time:1000});
			});
		}
		
</script>

</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 图片管理 <span class="c-gray en">&gt;</span> 导航图片管理<a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<!-- <div class="text-c"> 日期范围：
		<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'logmax\')||\'%y-%M-%d\'}'})" id="logmin" class="input-text Wdate" style="width:120px;" name="startDate">
		-
		<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'logmin\')}',maxDate:'%y-%M-%d'})" id="logmax" class="input-text Wdate" style="width:120px;" name="endDate">
		<input type="text" name="title" id="title" placeholder=" 标题" style="width:250px" class="input-text">
		<button name="" id="" class="btn btn-success" onclick="f_getList()"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
	</div> -->
	<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a class="btn btn-primary radius" onclick="image_add('添加图片信息','<%=basePath %>moduleImage/toAddImage.do','${pid }')" href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加</a>
	<a class="btn btn-success radius" onclick="history_show()" href="javascript:;"><i class="Hui-iconfont"></i> 图片记录</a></span> </div>
	<div class="mt-20">
	<input type="hidden" id="pid" name="pid" value="${pid }">
		<table id="active_table" class="table table-border table-bordered table-bg table-hover table-sort">
			
			<thead>
				<tr>
					<th scope="col" colspan="6">图片信息列表</th>
				</tr>
			
				<tr class="text-c">
					<th width="25"></th>					
					<th width="100">图片名称</th>
					<th width="100">备注</th>
					<th width="150">创建时间</th>
					<th width="120">操作</th>
				</tr>
			</thead>			
				<tbody>
				
				</tbody>

		</table>
	</div>
</div>
</body>
</html>