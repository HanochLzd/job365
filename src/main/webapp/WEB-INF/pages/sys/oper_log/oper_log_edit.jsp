<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp" %>
<html>
<head>
<title>系统日志列表</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 系统日志 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<div class="cl pd-5 bg-1 bk-gray"> <span class="l"> <a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> </span> <span class="r">共有数据：<strong>54</strong> 条</span> </div>
	<table class="table table-border table-bordered table-hover table-bg">
		<thead>
			<tr>
				<th scope="col" colspan="6">系统日志</th>
			</tr>
			<tr class="text-c">
				<th width="25"><input type="checkbox" value="" name=""></th>
				<th width="40">操作人</th>
				<th width="50">操作对象</th>
				<th width="70">操作类型</th>
				<th width="70">操作结果</th>
				<th width="300">操作描述</th>
				<th width="200">操作时间</th>
				<th width="200">主机IP地址</th>
				<th width="100">备注</th>
				<th width="100">操作</th>
			</tr>
		</thead>
		<tbody>
		    <c:forEach items="${sysOperLogs}" var="operLog">
		      <tr class="text-c">
		      <td><input type="checkbox" value="${ operLog.id}" name="operLogId"></td>
		      <td>${operLog.operUserName}</td>
		      <td>${operLog.operModel}</td>
		      <td>${operLog.operType}</td>
		      <td>${operLog.operResult}</td>
		      <td>${operLog.operDescription}</td>
		      <td><fmt:formatDate value="${operLog.operDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		      <td>${operLog.machIp}</td>
		      <td>${operLog.remark}</td>
		      <td class="f-14"><a title="编辑" href="javascript:;" onclick="admin_operLog_edit('操作日志编辑','<%=basePath %>operLog/toOperLogEdit.do?id='+'${ operLog.id}' ,'${ operLog.id}')" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除" href="javascript:;" onclick="admin_operLog_del(this,'${operLog.id}')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
		      </tr>
		    </c:forEach>		
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
		
		$.getJSON('<%=basePath%>operLog/delOper.do',{"id":id}, function(data) {
			
			$(obj).parents("tr").remove();
			layer.msg(data.message,{icon:1,time:1000});
		})
		
	});
}
/*批量删除*/
function datadel(ids){
	
}
</script>
</body>
</html>