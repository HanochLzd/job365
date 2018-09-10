<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp" %>

<html>
	<head>	
		<script type="text/javascript">
			var op = "${op}";				
			var deptTable;
				$(function(){
					deptTable=$("#dept_table").dataTable({
						"bServerSide": true,     //是否启动服务器端数据导入
		                "bFilter" : false,       //是否搜索栏
		                "bPaginate": true,       //是否显示分页器
		                "bInfo": true,           //是否显示表格的一些信息
		                "bJQueryUI": false,      //是否启用JQueryUI风格
		                "bLengthChange": true,   //是否显示每页大小的下拉框
		                "sPaginationType": "full_numbers", //分页样式
		                "sAjaxSource" : "<%=basePath%>dept/getDeptList.do", //请求数据的URL
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
					           "aTargets" : [1],   //第2列
					           "mData" : "orgName"
					        },
					        {
					           "aTargets" : [2],   //第3列
					           "mData" : "orgType",
		                	   "mRender" : function(a, b, c, d){
						               if(a == 0){
						                  return "校总会";
						               }else if(a== 1){
						                  return "学院分会";
						               }else{
						               	  return "地方分会";
						               }
					        	},
					        },
					        {
					           "aTargets" : [3],   //第4列
					           "mData" : "orgLeader",
					        },
					         {
					           "aTargets" : [4],   //第5列
					           "mData" : "orgContact",
					           "mRender" : function(a, b, c, d){
					           		return '<center>'+a+'</center>';
					           }
					        },				     
		                	{
					           "aTargets" : [5],   //第6列
					           "mData" : "orgDescription"
					        },
		                	{
					           "aTargets" : [6],   //第7列
					           "mData" : "createDate",
					           "mRender" : function(a, b, c, d){
					           		return '<center>'+a+'</center>';
					           }
					        },
					        {
					           "aTargets" : [7],   //第8列
					           "mData" : "orgStatus",
					           "mRender" : function(a, b, c, d){
					               if(a == 1){
					                  return '<center><span class="label label-success radius">已启用</span></center>';
					               }else{
					                  return '<center><span class="label label-defaunt radius">已停用</span></center>';
					               }
					           }
					        },				        
					        {
					           "aTargets" : [8],   //第9列
					           "mRender" : function(a, b, c, d){
					               if(c.orgStatus == 1){
					                  return '<center><a style="text-decoration:none" onClick="dept_stop(this,' + c.id + ')" href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;' +
					                         '<a title="编辑" href="javascript:;" onclick="admin_dept_edit('+c.id+')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;' +
					                         '<a title="删除" href="javascript:;" onclick="admin_dept_del(this,'+c.id+')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></center>';
					               }else{
					                  return '<center><a style="text-decoration:none" onClick="dept_start(this,' + c.id + ')" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe6e1;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;' +
					                         '<a title="编辑" href="javascript:;" onclick="admin_dept_edit('+c.id+')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'+
					                         '<a title="删除" href="javascript:;" onclick="admin_dept_del(this,'+c.id+')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></center>';
					               }
					           }
					        },       
		                	
		                ],  	
					
					});
				
				});
				
				
							
				/*管理员-部门-添加*/
				function admin_dept_add(title,url,w,h){
					layer_show(title,url,w,'600');
				}
				/*管理员-部门-编辑*/
				function admin_dept_edit(id){
					var url="<%=basePath %>dept/update.do?id="+id;
					layer_show('修改部门',url,'','500');
				}
				/*管理员-部门-删除*/
				function admin_dept_del(obj,id){
					layer.confirm('确认要删除吗？',function(index){
						var src="<%=basePath%>dept/delDeptById.do?&id="+id;
						$.post(src,function(data){
						var jsonReturn = eval("(" + data +")");
							if(jsonReturn.code=="1"){
								deptTable.fnDraw(true);//true停留在当前页，false返回第一页
								layer.msg('删除成功', {icon:6, time:1000});
							}else{
								layer.alert("请先移除部门下的用户！");
								layer.msg('删除失败', {icon:5, time:1000});
							}
							
						});
					
					});
						
				}				
				 /*部门-停用*/
		       function dept_stop(obj, id){
			      layer.confirm('确认要禁用此部门吗？',function(index){
			         var url = "<%=basePath%>dept/changeStatus.do";
			         $.post(url, {"id":id}, function(data){
			             var jsonReturn = eval("(" + data +")");
			             if(jsonReturn.code == "1"){	
			            	 deptTable.fnDraw(true);//true停留在当前页，false返回第一页
				             layer.msg('禁用成功!',{icon: 6,time:1000});
			             }else{	              
			            	 deptTable.fnDraw(true);//true停留在当前页，false返回第一页
				             layer.msg('禁用失败!',{icon: 5,time:1000});
			             }
			         });
			      });
		      }
		       /*部门-启用*/
		     function dept_start(obj, id){
			    layer.confirm('确认要启用此部门吗？',function(index){
			       var url = "<%=basePath%>dept/changeStatus.do";
			       $.post(url, {"id":id}, function(data){
			           var jsonReturn = eval("(" + data +")");
			           if(jsonReturn.code == "1"){	              
				           layer.msg('启用成功!',{icon: 6,time:1000});
				           deptTable.fnDraw(true);
			           }else{	            
				           layer.msg('启用失败!',{icon: 5,time:1000});
			           }
			       });
			    });
		     }
		     //获取行数
		     function get_checked_row_num(){
				return $("#dept_table tbody tr input[name='dept_list']:checked").length;
				
			}
		     //批量删除部门
		     function batch_delete(){
		       var ids = "";
				//遍历选中行
				$("#dept_table tbody tr input[name='dept_list']:checked").each(function(){
					ids = ids + $(this).val()+",";
				});					   
			    if(get_checked_row_num()<=0){
			        layer.msg("请选择部门!", {icon:1, time:1000});
			    }else{
			         layer.confirm('确认要批量删除部门吗？',function(index){
				       var url = "<%=basePath%>dept/delDept.do?&delIds="+ids;
				        $.post(url, function(data){
				            var jsonReturn = eval("(" + data +")");
				            if(jsonReturn.code=="1"){
				            		deptTable.fnDraw(true);
									layer.msg('删除成功!',{icon: 6,time:1000});
								}else{
									layer.alert("请先移除部门下的用户！");
									layer.msg('删除失败', {icon:1, time:1000});
									location.reload(true);
								}
				        });
			      });
			    }
			    }
		     
		     
				</script>
	</head>
	<body>
		<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 组织机构管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
		<div class="page-container">
			<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"> <a href="javascript:;" onclick="batch_delete()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
			 <a class="btn btn-primary radius" href="javascript:;" onclick="admin_dept_add('添加组织信息','<%=basePath%>dept/addDept.do','800')"><i class="Hui-iconfont">&#xe600;</i> 添加组织机构</a> </span>  </div>
			<div class="mt-20">
			<table id="dept_table" class="table table-border table-bordered table-hover table-bg table-sort">
				<thead>
					<tr>
						<th scope="col" colspan="11">组织机构列表</th>
					</tr>			
					<tr class="text-c">
						<th width="20"></th>
						<th width="150">组织名称</th>
						<th width="120">组织类型</th>
						<th width="120">组织负责人</th>
						<th width="150">组织联系方式</th>
						<th >组织描述</th>
						<th width="150">创建时间</th>
						<th width="120">组织状态</th>
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