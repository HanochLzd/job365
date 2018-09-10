<%@page import="java.net.URLDecoder"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="../../common/taglibs.jsp"%>
<html>
<head>
<title>留言列表信息</title>
</head>
<body>
	<input type="hidden" id="isTotal" name="isTotal" value="${isTotal}">
	<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>留言管理 <span class="c-gray en">&gt;</span> 留言列表管理<a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="page-container">
	<div class="text-c"> 日期范围：
			<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})" id="datemin" class="input-text Wdate" style="width:120px;" name="startDate">
			-
			<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})" id="datemax" class="input-text Wdate" style="width:120px;" name="endDate">
			<!-- <input type="text" class="input-text" style="width:250px" placeholder="请输入职位名称" id="resumeName" name="resumeName"> -->
			<button type="button" class="btn btn-success" id="" name="search" onclick="f_getList()"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
		</div>
	<table class="table table-border table-bordered table-hover table-bg" id="document_Table">
		<thead>
			<tr>
			<th scope="col" colspan="11">文档列表</th>
			</tr>
			<tr class="text-c">
				<th width="30"></th>
				<th width="60">求职者</th>
<!-- 				<th width="300">求职者留言</th>
				<th width="100">求职者留言时间</th> -->
				<th width="100">公司</th>
				<th width="100">职位</th>
				<th width="300">求职者留言</th>
				<th width="100">求职者留言时间</th> 
				
			</tr>
		</thead>
		<tbody>	
		</tbody>
	</table>
	<script type="text/javascript">

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
	         "sAjaxSource" : "<%=basePath%>message/getMessageListJson.do", //请求数据的URL
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
			           "mData" : "userName",
			            "mRender" : function(a, b, c, d){
				           return '<center>'+a+'</center>';
				        } 
			        },	
			         /* {
				           "aTargets" : [2],   
				           "mData" : "context" ,
				           "mRender" : function(a, b, c, d){
						       return '<center>'+a+'</center>';
						     } 
				        },	
			        
				      {
					         "aTargets" : [3],  
					          "mData" : "createDate",
					          "mRender" : function(a, b, c, d){
					          	return '<center>'+a+'</center>';
					        }
					},	 */
					 {
				           "aTargets" : [2],   
				           "mData" : "companyName",
				           "mRender" : function(a, b, c, d){
						       return '<center>'+a+'</center>';
						     }
				        },
			        {
			           "aTargets" : [3],  
			           "mData" : "positionName",
			           "mRender" : function(a, b, c, d){
			           		return '<center>'+a+'</center>';
			           }
			        },
					   {
						       "aTargets" : [4],  
						       "mData" : "comContext",
						       "mRender" : function(a, b, c, d){
						       	 return '<center>'+a+'</center>';
						      }
					   },
						 {
					       "aTargets" : [5],  
					       "mData" : "comCreateDate",
					       "mRender" : function(a, b, c, d){
					       	 return '<center>'+a+'</center>';
					      }
				   }
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
	
	</script>
</body>

</html>