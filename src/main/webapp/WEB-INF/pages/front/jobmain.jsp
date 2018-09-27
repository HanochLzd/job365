<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>找工作</title>
    <link rel="stylesheet" href="../front/css/resourceCom.css" type="text/css">
    <link rel="stylesheet" href="../front/css/e-book.css" type="text/css">
</head>
<body>
<c:import url="/WEB-INF/pages/front/common/head.jsp"></c:import>
<div class="wrapCon">
    <div class="indexTitle"><p class="title">工作分类</p></div>
    <div class="cly">
        <ul class="classify">
            <li>
                <span style="">地区分类：</span>
                <div id="cate1">
                    <a class="cur" id="cate1_all"  mytab ="0">全部</a>
                    <c:if test="${not empty cate1list}">
                    	<c:forEach  items="${cate1list}" var="cate1">
                    		<a href="javascript:void(0)"  mytab="${cate1.id}">${cate1.name}</a>
                    	</c:forEach>
                    </c:if>
                </div>
            </li>
            <li>
                <span>类型分类：</span>
                <div id="cate2">　  　  　  　  　
                    <a class="cur" id="cate2_all" mytab = "0">全部</a>
                    <c:if test="${not empty cate2list}">
                    	<c:forEach  items="${cate2list}" var="cate2">
                    		<a href="javascript:void(0)" mytab="${cate2.id}">${cate2.name}</a>
                    	</c:forEach>
                    </c:if>
                </div>
            </li>
        </ul>
    </div>
    <div class="wrapSort">
        <div class="sort fl">
            <span>排序：</span>
            <ul>
                <li class="normal cur">默认</li>
                <li class="uploadDate">薪资排行</li>
            </ul>
        </div>
        
    </div>
    <div class="wrapBook">
    	<c:if test="${not empty positionlist }">
    		<c:forEach  items="${positionlist}" var="plist">
                <a class="book" href="/job365/index/tojobdetail.do?id=${plist.id}">
            		<div class="bookIntro">
                	<h3>${plist.positionName}</h3>
                	<p><span>[地址]</span> <i>${plist.positionAddress}</i></p>
               	 	<p><span>[薪资]</span> <i>${plist.positionSalary}</i></p>
                	<p><span>[职位介绍]</span> <i>${plist.positionDesc}</i></p>
                	<p><span>[联系电话]</span> <i>${plist.positionPhone}</i></p>
            		</div>
        		</a>
             </c:forEach>
    	</c:if>
        
    </div>
    <div class="page fl">
        <ul id="pg">
            
        </ul>
    </div>
</div>
<div class="qqGroup">
        <ul>
          <li><img src="../front/images/group.png" alt=""><span>联系QQ：193698594</span></li>
          <li><img src="../front/images/group.png" alt=""><span>联系群组：1701825</span></li>
          <li><img src="../front/images/group.png" alt=""><span>联系电话：13146666666</span></li>
        </ul>
    </div>
    <div class="footer">
        <p>本网站致力于bulabulabulabulabula</p>
        <p>地址：bulabulabulabulabula 联系电话：0351-5628284 Email：aaaaaaaaa@163.com　QQ群:53691875</p>
        <p>笨ICP备08000920号</p>
    </div>
<script type="text/javascript" src="js/jquery.myProgress.js"></script>
<script type="text/javascript" src="js/resource.js"></script>
<script type="text/javascript">
		var totalpages = ${totalpages};
		var curpage = ${curpage};
		getpages(curpage,totalpages);
		function getpages(curPage,totalPages){
		var strpage ="<li  onclick=\"getTwDatas(1);\">首页</li>";
	   	if(curPage>1){
	   		strpage+="<li onclick=\"getTwDatas("+(curPage-1)+");\">上一页</li>";
   		}else{
   			strpage+="<li>上一页</li>";
   		}
   			
   		if(curPage==totalPages&&totalPages>2){
   			strpage+="<li  onclick=\"getTwDatas("+(curPage-2)+");\">"+(curPage-2)+"</li>";
   		}
   		if(curPage>1){
	   		strpage+="<li onclick=\"getTwDatas("+(curPage-1)+");\">"+(curPage-1)+"</li>";
   		}
   			strpage+="<li onclick=\"getTwDatas("+curPage+");\" class=\"cur\">"+curPage+"</li>";//当前页
   			
   		if(curPage<totalPages){
	   		strpage+="<li onclick=\"getTwDatas("+(curPage+1)+");\">"+(curPage+1)+"</li>";
   		}   			
   		if(curPage==1){
	   		if(curPage+1<totalPages){
	   			strpage+="<li onclick=\"getTwDatas("+(curPage+2)+");\">"+(curPage+2)+"</li>";
	   			}
   		}   			
   		if(curPage<totalPages){
	   		strpage+="<li onclick=\"getTwDatas("+(curPage+1)+");\">下一页</li>";
   		}else{
   			strpage+="<li>下一页</li>";
   		}
   		strpage+="<li onclick=\"getTwDatas("+totalPages+");\">尾页</li>";
	   	$("#pg").html(strpage);
	}
		function getTwDatas(curPage){
   	   		var data = {_t:new Date().getTime()};
   	   		data["curpage"]=curPage||"";
   	   			$.ajax({
					type:"get",
					url:"/job365/index/getpagejobdata.do",
					data:data,
					dataType:"json",
					success:function(data){
						 if(data.status==true){	
						 var html = "";						 			
						 for (var i =0 ;i<data.positionlist.length;i++){
								html+="<a class='book' href='/job365/index/tojobdetail.do?id="+data.positionlist[i].id+"'><div class='bookIntro'><h3>"+data.positionlist[i].positionName+"</h3><p><span>[地址]</span> <i>"+data.positionlist[i].positionAddress+"</i></p><p><span>[薪资]</span> <i>"+data.positionlist[i].positionSalary+"</i></p>";
                				html+="<p><span>[职位介绍]</span> <i>"+data.positionlist[i].positionDesc+"</i></p><p><span>[联系电话]</span> <i>"+data.positionlist[i].positionPhone+"</i></p></div></a>";
						 	}
						 $(".wrapBook").html(html);
						 getpages(curPage,data.totalpages);										
					}					
				}
			});
   	   	}

   	   	$(document).ready(function(){
   	   		$("#cate1>a").click(function(){
   	   			$("#cate1>a").removeClass("cur");
   	   			$(this).addClass("cur");
 			  	getdatabycate(curpage);   			
   	   		});
   	   		
   	   		$("#cate2>a").click(function(){
   	   			$("#cate2>a").removeClass("cur");
   	   			$(this).addClass("cur");
  				getdatabycate(curpage);
   	   		});   	   		
   	   	})
   	   	function getdatabycate(curPage){  	   	
   	   		var cate1 = $("#cate1>a.cur").attr("mytab");
   	   		var cate2 = $("#cate2>a.cur").attr("mytab");
   	   		var data = {_t:new Date().getTime()};
   	   			data["curpage"]=curPage||"";  	   			
   	   			data["cate1"]=cate1||"";
   	   			data["cate2"]=cate2||"";
   	   			$.ajax({
   	   				type:"get",
					url:"/job365/index/getdatebycate.do",
					data:data,
					dataType:"json",
					success:function(data){
						if(data.status==true){	
						 var html = "";						 			
						 for (var i =0 ;i<data.positionlist.length;i++){
								html+="<a class='book' href='/job365/index/tojobdetail.do?id="+data.positionlist[i].id+"'><div class='bookIntro'><h3>"+data.positionlist[i].positionName+"</h3><p><span>[地址]</span> <i>"+data.positionlist[i].positionAddress+"</i></p><p><span>[薪资]</span> <i>"+data.positionlist[i].positionSalary+"</i></p>";
                				html+="<p><span>[职位介绍]</span> <i>"+data.positionlist[i].positionDesc+"</i></p><p><span>[联系电话]</span> <i>"+data.positionlist[i].positionPhone+"</i></p></div></a>";
						 	}
						 $(".wrapBook").html(html);
						 getcatedatepages(curPage,data.totalpages);
					}
				}
   	   		})
   	   	}
   	   	function getcatedatepages(curPage,totalPages){
   	   		var strpage ="<li  onclick=\"getdatabycate(1);\">首页</li>";
	   	if(curPage>1){
	   		strpage+="<li onclick=\"getdatabycate("+(curPage-1)+");\">上一页</li>";
   		}else{
   			strpage+="<li>上一页</li>";
   		}
   			
   		if(curPage==totalPages&&totalPages>2){
   			strpage+="<li  onclick=\"getdatabycate("+(curPage-2)+");\">"+(curPage-2)+"</li>";
   		}
   		if(curPage>1){
	   		strpage+="<li onclick=\"getdatabycate("+(curPage-1)+");\">"+(curPage-1)+"</li>";
   		}
   			strpage+="<li onclick=\"getdatabycate("+curPage+");\" class=\"cur\">"+curPage+"</li>";//当前页
   			
   		if(curPage<totalPages){
	   		strpage+="<li onclick=\"getdatabycate("+(curPage+1)+");\">"+(curPage+1)+"</li>";
   		}   			
   		if(curPage==1){
	   		if(curPage+1<totalPages){
	   			strpage+="<li onclick=\"getdatabycate("+(curPage+2)+");\">"+(curPage+2)+"</li>";
	   			}
   		}   			
   		if(curPage<totalPages){
	   		strpage+="<li onclick=\"getdatabycate("+(curPage+1)+");\">下一页</li>";
   		}else{
   			strpage+="<li>下一页</li>";
   		}
   		strpage+="<li onclick=\"getdatabycate("+totalPages+");\">尾页</li>";
	   	$("#pg").html(strpage);
   	   	}
</script>
</body>
</html>
