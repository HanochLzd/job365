<%@page import="java.net.URLDecoder"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="../../common/taglibs.jsp"%>
<html>
<head>


<title>上传简历列表管理</title>
</head>
<body>
	<input type="hidden" id="isTotal" name="isTotal" value="${isTotal}">
	<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>简历管理 <span class="c-gray en">&gt;</span> 上传简历列表管理<a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="page-container">
	<div class="text-c"> 日期范围：
			<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})" id="datemin" class="input-text Wdate" style="width:120px;" name="startDate">
			-
			<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})" id="datemax" class="input-text Wdate" style="width:120px;" name="endDate">
			<input type="text" class="input-text" style="width:250px" placeholder="请输入文档名称" id="resumeName" name="resumeName">
			<button type="button" class="btn btn-success" id="" name="search" onclick="f_getList()"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
		</div>
	<div class="cl pd-5 bg-1 bk-gray mt-20"> 
		<span class="l">
		 <!-- <a href="javascript:;" onclick="batch_delete()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>批量删除</a> -->
		 <a class="btn btn-primary radius" data-title="上传简历 "  onclick="doc_add()" href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 上传简历 </a>
		</span>
	</div>
	<table class="table table-border table-bordered table-hover table-bg" id="document_Table">
		<thead>
			<tr>
			<th scope="col" colspan="11">简历 列表</th>
			</tr>
			<tr class="text-c">
				<th width="30"></th>
				<th width="100px">简历 标题</th>
				<th >简历 概述</th>
				<th width="80">上传人</th>
				<th width="150">上传日期</th>
				<!-- <th width="100">下载次数</th>  -->
				<th width="150">操作</th>
			</tr>
		</thead>
		<tbody>	
		</tbody>
	</table>
	<script type="text/javascript">
	//添加图集
	function doc_add(){
			var url = ("<%=basePath%>uploadResume/addDoc.do");
			var index = layer.open({
			type : 2,
			title : '上传简历',
			content : url,
			});
			layer.full(index);
	}

	//对象初始化
	var documentTable;
	//页面初始化
	$(function(){
			f_getList();
	});
	function f_getList(){
		var resumeName = $("#resumeName").val();
		var startDate = $("#datemin").val();
		var endDate = $("#datemax").val();
		documentTable = $("#document_Table").dataTable({
	         "bServerSide": true,     //是否启动服务器端数据导入
	         "bFilter" : false,       //是否搜索栏
	         "bPaginate": true,       //是否显示分页器
	         "bInfo": true,           //是否显示表格的一些信息
	         "bJQueryUI": false,      //是否启用JQueryUI风格
	         "bLengthChange": true,   //是否显示每页大小的下拉框
	         "sPaginationType": "full_numbers", //分页样式
	         "sServerMethod": "POST",
	         "bDestroy":true,
	         "sAjaxSource" : "<%=basePath%>uploadResume/getDocumentListJson.do", //请求数据的URL
	         "bProcessing" : true,	 //DataTables载入数据时，是否显示‘进度’提示  	
			    "aoColumnDefs": [        
			        {
			           "aTargets" : [0],   
			           "mData" : "id",     
			           "mRender" : function(a, b, c, d){
			               return '<input type="checkbox" id="'+ a +'" value="'+ a +'" >';
			            }
			        },
			        {
			           "aTargets" : [1],   
			           "mData" : "resumeName",
			            "mRender" : function(a, b, c, d){
				           return '<center>'+a+'</center>';
				        } 
			        },	
			        {
				           "aTargets" : [2],   
				           "mData" : "resumeDesc",
				           "mRender" : function(a, b, c, d){
						       return '<center>'+a+'</center>';
						     }
				        },	
			        {
			           "aTargets" : [3],   
			           "mData" : "createUser",
			           "mRender" : function(a, b, c, d){
					       return '<center>'+a+'</center>';
					     }
			        },	   
			        {
			           "aTargets" : [4],  
			           "mData" : "createDate",
			           "mRender" : function(a, b, c, d){
			           		return '<center>'+a+'</center>';
			           }
			        },
/* 			        {
				           "aTargets" : [5],  
				           "mData" : "downloadNum",
				           "mRender" : function(a, b, c, d){
				           		return '<center>'+a+'</center>';
				           }
				        }, */
			        {
				        	 "aTargets" : [5],  
					           "mRender" : function(a, b, c, d){
				        		   return 	'<center><a title="删除" href="javascript:;" onclick="document_del('+ c.id +')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;';
				        	 }
				           /* "aTargets" : [6],  
				           "mRender" : function(a, b, c, d){
			        		   return 	'<center><a title="删除" href="javascript:;" onclick="document_del('+ c.id +')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
					           +'<a title="下载" href="javascript:;" onclick="document_download('+ c.id + ')" class="ml-5" style="text-decoration:none">下载</a></center>' ;
			        	 } */	
			        },
			    ],
			    "fnServerParams" : function(aoData) {
				    aoData.push(	
				    		{ "name" : "startDate", "value" : startDate},   //自定义参数
					        { "name" : "endDate", "value" : endDate},
				    		{ "name" : "resumeName", "value" : resumeName}
				    );				
			    }
			    
	    });
	}
	
	function document_download(id){
		$.post('<%=basePath%>uploadResume/download.do',{"id":id}, function(data) {
			
			documentTable.fnDraw(true); 
		});	
<%-- 		   layer.confirm('确认要下载吗？',function(index){
			      var url = "<%=basePath%>uploadResume/download.do";
			      $.post(url, {"id":id}, function(data){
			           var jsonReturn = eval("(" + data +")");
				       layer.msg(jsonReturn.msg, {icon:6, time:1000});
				       documentTable.fnDraw(true);
			      });
				  
			   }); --%>
<%-- 		$.get('<%=basePath%>uploadResume/downloadTemplate.do',{"fileName":"backuser.xls"}, function(data) {
			
			documentTable.fnDraw(true); 
		});	 --%>
 
	  }
	
	function scenery_show(id){
		var url = "<%=basePath%>movie/addMovie.do?id="+id;
		var index = layer.open({
			type: 2,
			title: '图集预览',
			content: url
		});
		layer.full(index);	
	}
	
	function document_del(id){
		layer.confirm('确认要删除吗？',function(index){
			$.post('<%=basePath%>uploadResume/delDocument.do',{"id":id}, function(data) {
				var jsonReturn = eval("(" + data +")");
				layer.msg(jsonReturn.msg, {icon:1, time:1000});
				documentTable.fnDraw(true);
			});
		});
	}
	
	
	//上架
	function scenery_shangjia(obj , id){
		layer.confirm('是否发布？',function(index){
			$.post('<%=basePath%>scenery/shangjia.do',{"id":id}, function(data) {
				var jsonReturn = eval("(" + data +")");
				layer.msg(jsonReturn.msg, {icon:1, time:1000});
				sceneryTable.fnDraw(true);
			});
		});
	}

	//下架
	function scenery_xiajia(obj , id){
		layer.confirm('是否下架？',function(index){
			$.post('<%=basePath%>scenery/xiajia.do',{"id":id}, function(data) {
				var jsonReturn = eval("(" + data +")");
				layer.msg(jsonReturn.msg, {icon:1, time:1000});
				sceneryTable.fnDraw(true);
			});
		});
	}

	
	</script>
</body>

</html>