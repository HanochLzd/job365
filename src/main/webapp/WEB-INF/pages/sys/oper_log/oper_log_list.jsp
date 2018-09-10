<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp"%>
<html>
<head>
<title>系统日志列表</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 系统日志 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="text-c"> 日期范围：
		<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})" id="datemin" class="input-text Wdate" style="width:120px;" name="startDate">
		-
		<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})" id="datemax" class="input-text Wdate" style="width:120px;" name="endDate">
		<input type="text" class="input-text" style="width:250px" placeholder="请输入用户名称" id="userName" name="userName">
		<button type="button" class="btn btn-success" id="" name="search" onclick="f_getList()"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
	</div>
	<div class="cl pd-5 bg-1 bk-gray"> <span class="l"> <a href="javascript:;" onclick="batch_delete()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> </span> <span class="r"></span> </div>
	<table class="table table-border table-bordered table-hover table-bg" id="operLog_Table">
		<thead>
			<tr>
				<th scope="col" colspan="10">系统日志</th>
			</tr>
			<tr class="text-c">
				<th width="25"></th>
				<th width="150">操作人</th>
				<th width="150">操作对象</th>
				<th width="80">操作类型</th>
				<th >操作描述</th>
				<th width="150">操作时间</th>
				<th width="200">主机IP地址</th>
				<th width="80">操作</th>
			</tr>
		</thead>
		<tbody>	
		</tbody>
	</table>
</div>
<script type="text/javascript">
/*系统角色-添加*/
function sys_operLog_add(title,url,w,h){
	layer_show(title,url,w,h);
}
/*管理员-角色-编辑*/
function admin_operLog_edit(title,url,id,w,h){
	layer_show(title,url,w,h);
}
/*管理员-角色-删除*/
function admin_operLog_del(obj, id){
	 layer.confirm('确认要删除吗？',function(index){
	      var url = "<%=basePath%>operLog/delOper.do";
	      $.post(url, {"id":id}, function(data){
	           var jsonReturn = eval("(" + data +")");
		       layer.msg(jsonReturn.msg, {icon:6, time:2000});
		       operLogTable.fnDraw(true);
	      });
	   });
}
/*批量删除*/
function datadel(){
    
}
var operLogTable;

$(function(){
	f_getList();
	
});     

function f_getList(){
	var startDate = $("#datemin").val();
	var endDate = $("#datemax").val();
	var userName = $("#userName").val();
	operLogTable = $("#operLog_Table").dataTable({
         "bServerSide": true,     //是否启动服务器端数据导入
         "bFilter" : false,       //是否搜索栏
         "bPaginate": true,       //是否显示分页器
         "bInfo": true,           //是否显示表格的一些信息
         "bJQueryUI": false,      //是否启用JQueryUI风格
         "bLengthChange": true,   //是否显示每页大小的下拉框
         "sPaginationType": "full_numbers", //分页样式
         "bDestroy":true,
         "sAjaxSource" : "<%=basePath%>operLog/getOperLogListJson.do", //请求数据的URL
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
		           "mData" : "operUserName"
		        },	
		        {
		           "aTargets" : [2],   //第3列
		           "mData" : "operModel"
		        },	   
		        {
		           "aTargets" : [3],   //第4列
		           "mData" : "operType",
		           "mRender" : function(a, b, c, d){
		           		return '<center>'+a+'</center>';
		           }
		        },
		        {
		           "aTargets" : [4],   //第5列 操作描述
		           "mData" : "operDescription"
		        },
		        {
		           "aTargets" : [5],   //第6列 操作时间
		           "mData" : "operDate",
		           "mRender" : function(a, b, c, d){
		           		return '<center>'+a+'</center>';
		           }
		        },
		        {
		           "aTargets" : [6],   //第7列
		           "mData" : "machIp"
		        },
		        {
		           "aTargets" : [7],   //第10列
		           "mRender" : function(a, b, c, d){
		        	   return '<center><a title="删除" href="javascript:;" onclick="admin_operLog_del(this,'+ c.id +')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></center>';
		           }
		        },
		    ],
		    "fnServerParams" : function(aoData) {
			    aoData.push(
			           { "name" : "startDate", "value" : startDate},   //自定义参数
			           { "name" : "endDate", "value" : endDate},
			           { "name" : "userName", "value" : userName}
			    );				
		    }
		    
    });
}

function batch_delete(){
    var ids = "";
    $(":checkbox").each(function(){
        if(this.checked == true){
          ids += this.value + ",";
        }
    });
    if(ids.length == 0){
        layer.msg("请选择日志!", {icon:7, time:2000});
    }else{
        var url = "<%=basePath%>operLog/delBatch.do";
        $.post(url, {"delIds":ids}, function(data){
            var jsonReturn = eval("(" + data +")");
	        layer.msg(jsonReturn.msg, {icon:6, time:2000});
		    operLogTable.fnDraw(true);
        });
    }
}
</script>
</body>
</html>