<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'user_list.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <script type="text/javascript">
          
       var deptId = 0;
       
       var i = 1; 
       var resumeTable;
   	$(function(){
   		resumeList();
    });
  function resumeList(){
	var resumeName = $("#resumeName").val();
	var resumePosition = $("#resumePosition").val();
	var resumeWorkplace = $("#resumeWorkplace").val();
    	   resumeTable=$("#resume_table").dataTable({
             "sPaginationType": "full_numbers", //分页样式       
   	         "bServerSide": true,     //是否启动服务器端数据导入
	         "bFilter" : false,       //是否搜索栏
	         "bPaginate": true,       //是否显示分页器
	         "bInfo": true,           //是否显示表格的一些信息
	         "bJQueryUI": false,      //是否启用JQueryUI风格
	         "bLengthChange": true,   //是否显示每页大小的下拉框
	         "sPaginationType": "full_numbers", //分页样式
	         "sServerMethod": "POST",
	         "bDestroy":true, 
                "sAjaxSource" : "<%=basePath%>resume/getResumeList.do", //请求数据的URL
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
			           "mData" : "resumeName"			       
			        },	
			        {
				           "aTargets" : [2],   //第6列
				           "mData" : "resumeSex",     
				           "mRender" : function(a, b, c, d){
				               if(a == 0){
				                  return '<center>'+"男"+'</center>';
				               }else{
				                  return '<center>'+"女"+'</center>';
				               }
				           }
				           
				        },
		    	   
			        {
				        "aTargets" : [3],   //第4列
				        "mData" : "resumePhone"			        
			        },
			        {
				        "aTargets" : [4],   //5列
				        "mData" : "resumeEmail"
			        },	
			        {
				        "aTargets" : [5],   //6列
				        "mData" : "resumeWorkplace"
			        },
			        {
			           "aTargets" : [6],   //第7列
			           "mData" : "resumePosition",
			           "mRender" : function(a, b, c, d){
			           		return '<center>'+a+'</center>';
			           }
			        },
			        {
				           "aTargets" : [7],   //第8列
				           "mData" : "resumeSalary"
				           
				        },

			        {
			           "aTargets" : [8],   //第9列
			           "mData" : "resumeExperience"
			        },
			        {
				           "aTargets" : [9],   //第10列
				           "mData" : "resumeStatus",
				           "mRender" : function(a, b, c, d){
				               if(a == 1){
				                  return '<center><span class="label label-success radius">已启用</span></center>';
				               }else {
				                  return '<center><span class="label label-defaunt radius">已停用</span></center>';
				               }
				           }
				        },
			        {
			           "aTargets" : [10],   //第11列
			           "mRender" : function(a, b, c, d){
			        	 console.log(c);
						 if(c.resumeStatus == 1){
			                  return '<center><a style="text-decoration:none" onClick="resume_stop(this,' + c.id + ')" href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;' +
			                         '<a title="编辑" href="javascript:;" onclick="resume_edit('+ c.id +')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;' +
			                         '<a title="删除" href="javascript:;" onclick="resume_del(this,'+ c.id +')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></center>';
			               }else{
			                  return '<center><a style="text-decoration:none" onClick="resume_start(this,' + c.id + ')" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe6e1;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;' +
			                         '<a title="编辑" href="javascript:;" onclick="resume_edit('+ c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;' +
			                         '<a title="删除" href="javascript:;" onclick="resume_del(this,'+ c.id +')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></center>';
			               } 
			           }
			        }       
			    ],
			    "fnServerParams" : function(aoData) {
				    aoData.push(				            
				           { "name" : "resumeName", "value" : resumeName},//自定义参数
				           { "name" : "resumePosition", "value" : resumePosition},
				           { "name" : "resumeWorkplace", "value" : resumeWorkplace}
				           
				    );				
			    }
           });
         
       }
     //添加
		function resume_add(title,url){
			/* //先清除已打开的同一个页面
			removeIframeById("module_image_add");
			creatIframe(url,"添加图片信息","module_image_add"); */
			
			var index = layer.open({
	    		type : 2,
	    		title : '添加简历信息',
	    		content : url
	  			});
	  			layer.full(index);
		}
		
       
       /*用户-停用*/
       function resume_stop(obj, id){
	      layer.confirm('确认要禁用此简历吗？',function(index){
	         var url = "<%=basePath%>resume/modifyResumeStatus.do";
	         $.post(url, {"id":id}, function(data){
	             var jsonReturn = eval("(" + data +")");
	             if(jsonReturn.msg == "1"){	            
	            	 resumeTable.fnDraw(true);//true停留在当前页，false返回第一页
	            	 //alert("jinyongchengogng ");
		             layer.msg('禁用成功!',{icon: 6,time:2000});
		            
	             }else{	              
		             layer.msg('禁用失败!',{icon: 5,time:1000});
	             }
	             
	         });
	      });
      }

      /*用户-启用*/
     function resume_start(obj, id){
	    layer.confirm('确认要启用此简历吗？',function(index){
	       var url = "<%=basePath%>resume/modifyResumeStatus.do";
	       $.post(url, {"id":id}, function(data){
	           var jsonReturn = eval("(" + data +")");
	           if(jsonReturn.msg == "1"){
	        	   resumeTable.fnDraw(true);
		           layer.msg('启用成功!',{icon: 6,time:1000});
	           }else{	            
		           layer.msg('启用失败!',{icon: 5,time:1000});
	           }
	       });
	    });
     }
     
  
     
     function resume_edit(id){
			
			var url="<%=basePath %>resume/modifyResume.do?id="+id;	
			/* removeIframeById("active_edit_"+id);
			creatIframe(url,"修改校友风采信息","active_edit_"+id); */
			var index = layer.open({
	    		type : 2,
	    		title : '修改简历信息',
	    		content : url
	  			});
	  			layer.full(index);
		}
  
     
     
     /*用户-删除*/
    function resume_del(obj, id){
	   layer.confirm('确认要删除吗？',function(index){
	      var url = "<%=basePath%>resume/delResume.do";
	      $.post(url, {"id":id}, function(data){
	           var jsonReturn = eval("(" + data +")");
		       layer.msg(jsonReturn.msg, {icon:6, time:1000});
		       resumeTable.fnDraw(true);
	      });
		  
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
	        layer.msg("请选择用户!", {icon:7, time:1000});
	    }else{
	        layer.confirm('确认要删除吗？',function(index){
				var url = "<%=basePath%>resume/batchDeleteResume.do";
				$.post(url, {"ids" : ids }, function(data) {
						var jsonReturn = eval("(" + data + ")");
						layer.msg(jsonReturn.msg, {
							icon : 1,
							time : 1000
						});
					 resumeTable.fnDraw(true);
					});
				});
	    }
    }
<%--     function search(){
    	var resumeName = $("#resumeName").val();
    	var url="<%=basePath %>resume/resumeName.do?resumeName="+resumeName;
    	window.location.href = url;
    } --%>
</script> 
  </head>
  
<body>

<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>求职者管理<span class="c-gray en">&gt;</span> 简历管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<div class="cl pd-5 bg-1 bk-gray mt-20"> 
	<span class="l"><a href="javascript:;" onclick="batch_delete()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
	 <a href="javascript:;" onclick="resume_add('添加简历信息','<%=basePath %>resume/addResume.do')" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加简历信息</a>&nbsp;&nbsp;&nbsp;&nbsp;
	 <input type="text" class="input-text" style="width:150px" placeholder="请输入求职者姓名" id="resumeName" name="resumeName">
	 <input type="text" class="input-text" style="width:150px" placeholder="请输入求职者职位" id="resumePosition" name="resumePosition">
	 <input type="text" class="input-text" style="width:150px" placeholder="请输入求职者地点" id="resumeWorkplace" name="resumeWorkplace">
	<button type="button" class="btn btn-success" id="" name="search" onclick="resumeList()"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
	 </span> 
	 </div>	
	
	
	<div class="mt-20">
	<table id="resume_table" class="table table-border table-bordered table-hover table-bg table-sort">
		<thead>
			<tr class="text-c">
				<th width="25"></th>
				<th width="100">求职者姓名</th>
				<th width="50">性别</th>
				<th width="150">电话</th>
				<th width="200">邮箱</th>								
				<th width="150">期望工作地点</th>								
				<th width="100">期望职位</th>
				<th width="100">期望薪资</th>				
				<th width="250">工作经验</th>
				<th width="100">状态</th>
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
