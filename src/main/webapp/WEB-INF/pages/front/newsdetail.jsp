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
    <title>新闻详细</title>
    <link rel="stylesheet" href="../front/css/eduMes_3.css" type="text/css">
</head>
<body>
<c:import url="/WEB-INF/pages/front/common/head.jsp"></c:import>
<div class="wrapCon">
    <div class="palce">
      <span>您的位置：</span><span >新闻咨询</span><span>></span><span>新闻详细</span>
  </div>
    <div class="wrapArt">
        <h1>${news.newsTitle}</h1>
        <div class="artIntro">
            <div class="time fl"><span>时间：</span><i>${news.createDate}</i></div>
            <!-- <div class="fontSize fl"><span>字体设置：</span> <i class="big">大</i><i class="middle">中</i><i class="small">小</i></div> -->            
            <div id="bdshare" class="share fl sharing bdshare_t bds_tools get-codes-bdshare bdsharebuttonbox" style="float:none;"><a href="javascript:void(0);" class="bds_more" data-cmd="more">我要分享</a></div>
        </div>
        <div class="article">
            <img src="<%=basePath %>${news.imagePath}" alt="">
            ${news.newsContent}
        </div>
        <div class="source">
            <ul>
                <li><a href="javascript:void(0);" onclick="window.print();">【打印】</a></li>
                <li><a href="#">【顶部】</a></li>
                <li><a href="javascript:history.go(-1)">【关闭】</a></li>
            </ul>
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
    <!--百度分享到应用js--> 
	<script type="text/javascript" id="bdshare_js" data="type=tools" ></script> 
	<script type="text/javascript" id="bdshell_js"></script> 
	<script type="text/javascript">
	document.getElementById("bdshell_js").src = "http://share.baidu.com/static/js/shell_v2.js?t=" + new Date().getHours();
	</script> 
	<!--百度分享到应用js-->	
<script type="text/javascript">
  $(document).ready(function(){
  	$("#plane>li").removeClass('select');
	$("#news").addClass('select');
      $(".big").click(function(){
          $(".article p").css("font-size","16px");
      });
      $(".middle").click(function(){
          $(".article p").css("font-size","14px");
      });
      $(".small").click(function(){
          $(".article p").css("font-size","12px");
      })
  })
</script>
</body>
</html>
