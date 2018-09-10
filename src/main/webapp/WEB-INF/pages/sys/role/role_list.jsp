<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp" %>
<%@ page isELIgnored="false"%>
<html>
<head>
<title>系统角色列表</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 角色管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<div class="cl pd-5 bg-1 bk-gray"> <span class="l"> <a href="javascript:;" onclick="batch_delete_role()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a class="btn btn-primary radius" href="javascript:;" onclick="role_add('添加图片信息','<%=basePath %>role/addRole.do','','310')"><i class="Hui-iconfont">&#xe600;</i> 添加角色</a> </span> <span class="r">共有数据：<strong>${roleList.size()}</strong> 条</span> </div>
	<table class="table table-border table-bordered table-hover table-bg">
		<thead>
			<tr>
				<th scope="col" colspan="6">角色列表</th>
			</tr>
			<tr class="text-c">
				<th width="25"><input type="checkbox" value="" name=""></th>
				<th width="40">ID</th>
				<th width="200">角色名</th>
				<th width="300">描述</th>
				<th width="70">操作</th>
			</tr>
		</thead>
		<tbody>
		    <c:forEach items="${roleList}" var="role">
		      <tr class="text-c">
		      <td><input type="checkbox" value="${ role.id}" name="roleId" ></td>
		      <td>${role.id}</td>
		      <td>${role.roleName}</td>
		      <td>${role.roleDesc}</td>
		      
		      <td class="f-14"><a title="编辑" href="javascript:;" onclick="admin_role_edit('角色编辑','<%=basePath %>role/editRole.do','${role.id }','','310')" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
		       <a title="删除" href="javascript:;" onclick="admin_role_del(this,'${role.id}')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
		       <a title="授权" href="javascript:;" onclick="role_menu('为角色赋权限','<%=basePath %>role/roleMenu.do','${role.id}',400,400)" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe62d;</i></a></td>
		       
		      
		      </tr>
		    </c:forEach>		
		</tbody>
	</table>
</div>
<script type="text/javascript">

function role_menu(title,url,id,w,h){
	
	layer_show(title,url+"?"+"roleId="+id,w,h);
}

//添加
function role_add(title,url,w,h){
	
		layer_show(title,url,w,h);
	
}
/*管理员-角色-编辑*/
function admin_role_edit(title,url,id,w,h){
	
	layer_show(title,url+"?"+"roleId="+id,w,h);
}
/*管理员-角色-删除*/
function admin_role_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		
		$.getJSON('<%=basePath%>role/roledel.do',{"id":id}, function(data) {
			
			$(obj).parents("tr").remove();
			layer.msg(data.msg,{icon:6,time:1000});
			location.fnDraw(true);
			
		});
		
	});
}
//[name='roleId'] [checked='checked']
function batch_delete_role(){
      var items = $("input[name='roleId']:checked");
      var length = items.length;
      var ids="";
      if(length != 0){
           for(var i=0; i<length; i++) {
              ids += items[i].value;
              ids +=",";
           }
           ids = ids.substring(0, ids.length-1);
           layer.confirm('确认要删除吗？',function(index){
		
	           $.getJSON('<%=basePath%>role/batchDelRole.do',{"ids":ids},function (data){
			      layer.alert(data.msg, {icon: 6,time:0}, function(data){
			    			var index = parent.layer.getFrameIndex(window.name);
						    window.parent.location.reload(true);
							parent.layer.close(index); 
			    		
			    	});
           });
		});
           
      }else {
          layer.msg("请选择角色!", {icon:7, time:2000});
      }
    
      
}
</script>
</body>
</html>