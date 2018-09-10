<%@page import="java.net.URLDecoder"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="../../common/taglibs.jsp"%>
<html>
<head>


<title>新闻资讯列表</title>
</head>
<body>
<input type="hidden" id="isTotal" name="isTotal" value="${isTotal}">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 校友管理 <span class="c-gray en">&gt;</span> 新闻资讯管理<a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
<div class="text-c"> 日期范围：
		<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})" id="datemin" class="input-text Wdate" style="width:120px;" name="startDate">
		-
		<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})" id="datemax" class="input-text Wdate" style="width:120px;" name="endDate">
		<input type="text" class="input-text" style="width:250px" placeholder="请输入资讯标题" id="newsTitle" name="newsTitle">
		<button type="button" class="btn btn-success" id="" name="search" onclick="f_getList()"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
	</div>
<div class="cl pd-5 bg-1 bk-gray mt-20"> 
	<span class="l">
	 <a href="javascript:;" onclick="batch_delete()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>批量删除</a>
	 <a class="btn btn-primary radius" data-title="添加新闻"  onclick="news_add()" href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加资讯</a>
	</span>
	
</div>
	<table class="table table-border table-bordered table-hover table-bg" id="newsinfo_Table">
		<thead>
			<!-- <tr>
				<th scope="col" colspan="10">新闻资讯列表</th>
				
			</tr> -->
			<tr>
				<c:if test="${isTotal ==1}"><th scope="col" colspan="10">新闻资讯列表</th></c:if>
				<c:if test="${isTotal !=1}"><th scope="col" colspan="9">新闻资讯列表</th></c:if>
			</tr>
			<tr class="text-c">
				<th ></th>
				<th >资讯标题</th>
				<th width="150">备注</th>
				<th width="150">创建时间</th>
				<th width="150">创建人</th>
				<th width="120">资讯状态</th>
				<th width="150">操作</th>
			</tr>
		</thead>
		<tbody>	
		</tbody>
	</table>
</div>
<script type="text/javascript">



//删除
function newsinfo_del(obj, id){
	layer.confirm('确认要删除吗？',function(index){
		$.post('<%=basePath%>news/delNews.do',{"id":id}, function(data) {
			var jsonReturn = eval("(" + data +")");
		       layer.msg(jsonReturn.msg, {icon:6, time:1000});
		       newsinfoTable.fnDraw(true);
		});
	});
}
//批量删除
function batch_delete(){
	var ids = "";
	$(":checkbox").each(function(){
		if(this.checked == true){
		  ids += this.value + ",";
		}
	});
	if(ids.length == 0){
		layer.msg("请选择资讯信息!", {icon:7, time:1000});
	}else{
		layer.confirm('确认要删除吗？',function(index){
				var url = "<%=basePath%>news/delBatch.do";
				$.post(url, {
					"delIds" : ids
					}, function(data) {
						var jsonReturn = eval("(" + data + ")");
						layer.msg(jsonReturn.msg, {
							icon : 6,
							time : 1000
						});
						newsinfoTable.fnDraw(true);
					});
				});
			}
		}

//审核
function newsinfo_shenhe(obj , id){
	layer.confirm('是否通过审核？',function(index){
		$.post('<%=basePath%>news/changeStatus.do',{"id":id}, function(data) {
			var jsonReturn = eval("(" + data +")");
			newsinfoTable.fnDraw(true);
	        layer.msg('审核通过!',{icon: 6,time:1000});
			});
	});
}

//上架
function newsinfo_shangjia(obj , id){
	layer.confirm('是否发布？',function(index){
		$.post('<%=basePath%>news/shangjia.do',{"id":id}, function(data) {
			var jsonReturn = eval("(" + data +")");
			newsinfoTable.fnDraw(true);
	        layer.msg('发布成功!',{icon: 6,time:1000});
		});
	});
}

//上架
function newsinfo_xiajia(obj , id){
	layer.confirm('是否下架？',function(index){
		$.post('<%=basePath%>news/xiajia.do',{"id":id}, function(data) {
			var jsonReturn = eval("(" + data +")");
			newsinfoTable.fnDraw(true);
	        layer.msg('下架成功!',{icon: 6,time:1000});
		});
	});
}

//添加资讯
function news_add(){
	<%-- //先清除已打开的同一个页面
	removeIframeById("newsinfo_add");
	creatIframe(url,"添加新闻资讯","newsinfo_add"); 
	'添加新闻资讯','<%=basePath%>newsinfo/addNewsinfo.do' --%>
	
		var url = ("<%=basePath%>news/addNews.do");
		var index = layer.open({
		type : 2,
		title : '添加新闻资讯',
		content : url,
		});
		layer.full(index);
}

//修改资讯
function newsinfo_edit(id){
	<%--  var url = "<%=basePath%>newsinfo/modifyNewsinfo.do?id="+id;
	 removeIframeById("newsinfo_edit_"+id);
	 creatIframe(url,"修改新闻资讯","newsinfo_edit_"+id); --%>
	 
	 var url = "<%=basePath%>news/modifyNews.do?id="+id;
	  var index = layer.open({
	    type : 2,
	    title : '修改新闻资讯',
	    content : url,
	  });
	  layer.full(index);
}


function newsinfo_show(id){
	var url = "<%=basePath%>news/newsShow.do?id="+id;
	var index = layer.open({
		type: 2,
		title: '资讯预览',
		content: url
	});
	layer.full(index);
}

//对象初始化
var newsinfoTable;

//页面初始化
$(function(){
	
		
		f_getList();
	
	
});


function f_getList(){
	var isTotal = $("#isTotal").val();
	var newsTitle = $("#newsTitle").val();
	var startDate = $("#datemin").val();
	var endDate = $("#datemax").val();
	newsinfoTable = $("#newsinfo_Table").dataTable({
         "bServerSide": true,     //是否启动服务器端数据导入
         "bFilter" : false,       //是否搜索栏
         "bPaginate": true,       //是否显示分页器
         "bInfo": true,           //是否显示表格的一些信息
         "bJQueryUI": false,      //是否启用JQueryUI风格
         "bLengthChange": true,   //是否显示每页大小的下拉框
         "sPaginationType": "full_numbers", //分页样式
         "sServerMethod": "POST",
         "bDestroy":true,
         "sAjaxSource" : "<%=basePath%>news/getNewsListJson.do", //请求数据的URL
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
		           "mData" : "newsTitle",
		           "mRender" : function(a, b, c, d){
			           return '<u style="cursor:pointer" class="text-primary" onClick="newsinfo_show('+c.id+')" title="预览" value="">'+c.newsTitle+'</u>';
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
		           "mData" : "createUser",
		           "mRender" : function(a, b, c, d){
		           		return '<center>'+a+'</center>';
		           }
		        },
		       
			    {
				   "aTargets" : [5],   //第7列
				   "mData" : "newsStatus",
			        "mRender" : function(a, b, c, d){
			        	
			        	console.log(c)
				    if(c.newsStatus == 0){
					   return "<center><span class='label label-defaunt radius'>草稿</span></center>";
						}else{
							if(c.isShowTop == 0){
								return "<center><span class='label label-defaunt radius'>未发布</span></center>";
							}else{
								return "<center><span class='label label-success radius'>已发布</span></center>";
							}
					   
						}
					 }
			    },
		        {
		           "aTargets" : [6],   //第9列
		           "mRender" : function(a, b, c, d){
		        	   if(c.newsStatus == 0){
			        	    return  '<center><a title="审核" href="javascript:;" onclick="newsinfo_shenhe(this,'+ c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe602;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;' 
			        	    +'<a title="删除" href="javascript:;" onclick="newsinfo_del(this,'+ c.id +')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
			        	    +'<a title="编辑" href="javascript:;" onclick="newsinfo_edit('+ c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a></center>' ;
		        	   }else{
		        		    if(c.isShowTop == 0){
		        		    	return 	'<center>&nbsp;<a style="text-decoration:none" onClick="newsinfo_shangjia(this,' + c.id + ')" href="javascript:;" title="发布"><i class="Hui-iconfont">&#xe603;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
		        		    	+'<a title="删除" href="javascript:;" onclick="newsinfo_del(this,'+ c.id +')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
				        	    +'<a title="编辑" href="javascript:;" onclick="newsinfo_edit('+ c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a></center>' ;
		        		   	}else{
		        		   		return '<center>&nbsp;<a style="text-decoration:none" onClick="newsinfo_xiajia(this,' + c.id + ')" href="javascript:;" title="下架"><i class="Hui-iconfont">&#xe6de;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
		        		    	+'<a title="删除" href="javascript:;" onclick="newsinfo_del(this,'+ c.id +')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
				        	    +'<a title="编辑" href="javascript:;" onclick="newsinfo_edit('+ c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a></center>' ;
		        		   	};
		        	   };
		           }
		        },
		    ],
		    "fnServerParams" : function(aoData) {
			    aoData.push(	
			    		{ "name" : "startDate", "value" : startDate},   //自定义参数
				        { "name" : "endDate", "value" : endDate},
			    		{ "name" : "newsTitle", "value" : newsTitle},
			    		{ "name" : "isTotal", "value" : isTotal}
			    );				
		    }
		    
    });
}
</script>
</body>
</html>