<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title>职位列表</title>
</head>
<body class="pos-r">
<!-- <div class="pos-a" style="width:200px;left:0;top:0; bottom:0; height:100%; border-right:1px solid #e5e5e5; background-color:#f5f5f5; overflow:auto;">
	<ul id="treeDemo" class="ztree"></ul>
</div> -->
<div style="">
	<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 职位管理 <span class="c-gray en">&gt;</span> 职位列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
	<div class="page-container">
		<div class="text-c"> 日期范围：
			<input type="text" onfocus="WdatePicker({ maxDate:'#F{$dp.$D(\'logmax\')||\'%y-%M-%d\'}' })" id="logmin" class="input-text Wdate" style="width:120px;">
			-
			<input type="text" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'logmin\')}',maxDate:'%y-%M-%d' })" id="logmax" class="input-text Wdate" style="width:120px;">
			<input type="text" name="positionName" id="positionName" placeholder=" 职位名称" style="width:250px" class="input-text">
			<button name="" id="" class="btn btn-success" onclick="f_getList()"><i class="Hui-iconfont">&#xe665;</i>搜职位</button>
		</div>
		<div class="mt-20">
			<table class="table table-border table-bordered table-bg table-hover table-sort" id="position_table">
				<thead>
					<tr class="text-c">
						<th width="40"></th>	
						<th width="60">职位名称</th>
						<th width="80">职位薪水</th>
						<th width="80">工作地点</th>
						<th width="100">职位描述</th>
						<!-- <th width="60">职位要求</th> -->
						<th width="60">公司名称</th>
						<th width="100">联系电话</th>
						<th width="150">发布时间</th>
						<th width="60">职位状态</th>
						<th width="100">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function(){

	
	f_getList();
	
	
});
function f_getList(){
	
	var positionName = $("#positionName").val();
	var startDate = $("#logmin").val();
	
	
	var endDate = $("#logmax").val();
	newsinfoTable = $("#position_table").dataTable({
         "bServerSide": true,     //是否启动服务器端数据导入
         "bFilter" : false,       //是否搜索栏
         "bPaginate": true,       //是否显示分页器
         "bInfo": true,           //是否显示表格的一些信息
         "bJQueryUI": false,      //是否启用JQueryUI风格
         "bLengthChange": true,   //是否显示每页大小的下拉框
         "sPaginationType": "full_numbers", //分页样式
         "sServerMethod": "POST",
         "bDestroy":true,
         "sAjaxSource" : "<%=basePath%>position/getPositionListJson.do", //请求数据的URL
         "bProcessing" : true,	 //DataTables载入数据时，是否显示‘进度’提示  	
		    "aoColumnDefs": [        
		        {
		           "aTargets" : [0],   //第1列
		           "mData" : "id",     
		           "mRender" : function(a, b, c, d){
		        	  
		               return '<input type="checkbox" id="'+ a +'" value="'+ a +'" >';
		            }
		        },
		        
		       
		        {
		           "aTargets" : [1],   //第2列
		           "mData" : "positionName",
		           "mRender" : function(a, b, c, d){
		        	   
		        	   
			           return '<u style="cursor:pointer" class="text-primary" onClick="positionInfo_show('+c.id+')" title="预览" value="">'+c.positionName+'</u>';
			        }
		        },	
		        {
		           "aTargets" : [2],   //第3列
		           "mData" : "positionSalary"
		           
		        },	   
		        {
		           "aTargets" : [3],   //第4列
		           "mData" : "positionAddress",
		           "mRender" : function(a, b, c, d){
		           		return '<center>'+a+'</center>';
		           }
		        },
		        {
			           "aTargets" : [4],   //第5列
			           "mData" : "positionRequire",
			           "mRender" : function(a, b, c, d){
			           		return '<center>'+a+'</center>';
			           }
			        },
/* 		        {
		           "aTargets" : [4],   //第5列
		           "mData" : "positionDesc",
		           "mRender" : function(a, b, c, d){
		           		return '<center>'+a+'</center>';
		           }
		        }, */
		       /*  {
			           "aTargets" : [5],   //第5列
			           "mData" : "positionRequire",
			           "mRender" : function(a, b, c, d){
			           		return '<center>'+a+'</center>';
			           }
			     }, */
		        
		        {
			           "aTargets" : [5],   //第6列
			           "mData" : "companyName",
			           "mRender" : function(a, b, c, d){
			           		return '<center>'+a+'</center>';
			           }
			        },
			        
		        {
			           "aTargets" : [6],   //第7列
			           "mData" : "positionPhone",
			           "mRender" : function(a, b, c, d){
			           		return '<center>'+a+'</center>';
			           }
			        },
			        {
				           "aTargets" : [7],   //第8列
				           "mData" : "createDate",
				           "mRender" : function(a, b, c, d){
				        	  
				           		return '<center>'+a+'</center>';
				           }
				        },         
			       
			    {
				   "aTargets" : [8],   //第9列
				   "mData" : "status",
			        "mRender" : function(a, b, c, d){
			        	
			        	
				    if(c.status == 0){
					   return "<center><span class='label label-defaunt radius'>未申请</span></center>";
						}/* else if(c.status == 1){
							return "<center><span class='label label-defaunt radius'></span></center>";
					   
						} */ else{
							return "<center><span class='label label-success radius'>已申请</span></center>";
						} 
				    
				    
				   
					 }
			    },
			    {
			           "aTargets" : [9],   //第10列
			           "mRender" : function(a, b, c, d){
			        	   if(c.status == 0){
				        	    return  '<center><a title="申请" href="javascript:;" onclick="position_shenhe(this,'+ c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe603;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;' 
				        	    +'<a title="编辑" href="javascript:;"   onclick="position_messgae('+ c.id +')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a></center>' ;
			        	   }/* else  if(c.status==1){
			        		   return 	'<center>&nbsp;<a style="text-decoration:none" onClick="position_start(this,' + c.id + ')" href="javascript:;" title="发布"><i class="Hui-iconfont">&#xe603;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
				        	    +'<a title="编辑" href="javascript:;" onclick="position_edit('+ c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a></center>' ;
			        	   }  */else{
			        		   return '<center>&nbsp;<a style="text-decoration:none" onClick="position_stop(this,' + c.id + ')" href="javascript:;" title="取消申请"><i class="Hui-iconfont">&#xe6de;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
				        	   /*  +'<a title="编辑" href="javascript:;" onclick="position_messgae()" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a></center>' ; */
			        		   +'<a title="编辑" href="javascript:;" onclick="position_messgae('+ c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a></center>' ;
			        	   }
			        	   
			        	   
			        	   
			           }
			        },
		      
		    ],
		    "fnServerParams" : function(aoData) {
			    aoData.push(	
			    		{ "name" : "startDate", "value" : startDate},   //自定义参数
				        { "name" : "endDate", "value" : endDate},
			    		{ "name" : "positionName", "value" : positionName}
			    		
			    );				
		    }
		    
    });
}
<%-- function position_messgae(title,url,id,w,h){
	var url = "<%=basePath%>message/createMessage.do";
      layer_show(title, url, w, h);
} --%>
/*职位-编辑*/
function position_messgae(id){
	var index = layer.open({
		type: 2,
		title: '留言',
		content:'<%=basePath%>message/createMessage.do?id='+id,
	});
	layer.full(index);
}

	$('.table-sort').dataTable({
		"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"aoColumnDefs": [
		  {"orderable":false,"aTargets":[0,7]}// 制定列不参与排序
		]
	});

	/*职位-编辑*/
	function position_edit(id){
		 var url = "<%=basePath%>company/modifyCompany.do?id="+id;
		var index = layer.open({
			type: 2,
			title: '职位编辑',
			content:'<%=basePath%>position/edit.do?id='+id,
		});
		layer.full(index);
	}
	/*申请职位*/
	function position_shenhe(obj,id){
		layer.confirm('确认申请？',function(index){
			$.post('<%=basePath%>position/shenhe.do',{"id":id}, function(data) {
				var jsonReturn = eval("(" + data +")");
				newsinfoTable.fnDraw(true);
		        layer.msg('申请成功!',{icon: 6,time:1000});
				});
		});
	}
	/*取消申请*/
	function position_stop(obj,id){
		layer.confirm('取消申请？',function(index){
			$.post('<%=basePath%>position/stop.do',{"id":id}, function(data) {
				var jsonReturn = eval("(" + data +")");
				newsinfoTable.fnDraw(true);
		        layer.msg('取消成功!',{icon: 6,time:1000});
			});
		});
	}


</script>
</body>
</html>