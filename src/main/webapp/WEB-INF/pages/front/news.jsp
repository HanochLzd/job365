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
    <title>新闻咨询</title>
    <link rel="stylesheet" href="../front/css/djHead.css" type="text/css">
    <link rel="stylesheet" href="../front/css/sxdjnews.css" type="text/css">
    <link rel="stylesheet" href="../front/css/eduMes_2.css" type="text/css">
</head>
<body>
<c:import url="/WEB-INF/pages/front/common/head.jsp"></c:import>
<div class="inform">
    <h3>通知公告</h3>
    <div class="informCon" >
        <ul id= "listmain">
        	<c:forEach  items="${newslist}" var="news">
        		<li><a href=""> ${news.newsTitle}</a><span>${news.createDate}</span></li>
        	</c:forEach>
        </ul>
    </div>
</div>
<div class="wrapCon">
    <div class="slideNav fl">
        <div class="indexTitle"><p class="title">新闻咨询</p></div>
        <ul>
            <li class="cur"><a href="">新闻热点</a></li>
        </ul>
    </div>
    <div class="wrapNews fr">
        <div class="wrapDetail">        
        	<c:forEach  items="${newslist}" var="news">
        		<a href="tonewsdetail.do?id=${news.id}" class="news">
                <img src="<%=basePath %>${news.imagePath}" alt="">
                <div class="intro">
                    <h3>${news.newsTitle}</h3>
                    <span>${news.createDate}</span>
                    <p>${news.newsContent}</p>
                </div>
            </a>
        	</c:forEach>
            
        </div>
        <div class="pages">
            <ul id= "pg"></ul>
        </div>
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
<script type="text/javascript" src="../front/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="../front/js/scroll.js"></script>
</body>
<script type="text/javascript">
	var totalpages = ${totalpages};
	var curpage = ${curpage};
	$("#plane>li").removeClass('select');
	$("#news").addClass('select');
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
					url:"/job365/index/getpagedata.do",
					data:data,
					dataType:"json",
					success:function(data){
						 if(data.status==true){	
						 var html1 = "";
						 var html2 = "";			
						 for (var i =0 ;i<data.newslist.length;i++){
								html1+="<li><a href=''> "+data.newslist[i].newsTitle+"</a><span>"+data.newslist[i].createDate+"</span></li>"
						 		html2+="<a href='tonewsdetail.do?id="+data.newslist[i].id+"' class='news'><img src='"+data.newslist[i].imagePath+"' alt=''><div class='intro'><h3>"+data.newslist[i].newsTitle+"</h3><span>"+data.newslist[i].createDate+"</span><p>"+data.newslist[i].newsContent+"</p></div></a>";
						 	}
						 $("#listmain").html(html1);
						 $(".wrapDetail").html(html2);
						 getpages(curPage,data.totalpages);										
					}					
				}
			});
   	   	}
</script>
</html>
