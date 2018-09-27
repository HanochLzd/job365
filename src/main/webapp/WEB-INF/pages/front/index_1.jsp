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
    <title>首页</title>
    <link rel="stylesheet" href="../front/css/global.css" type="text/css">
    <link rel="stylesheet" href="../front/css/head.css" type="text/css">
    <link rel="stylesheet" href="../front/css/headFooter.css" type="text/css">
    <link rel="stylesheet" href="../front/css/index_1.css" type="text/css">
	<link rel="stylesheet" href="../front/css/login.css" type="text/css">
</head>
<body>
<c:import url="/WEB-INF/pages/front/common/head.jsp"></c:import>
<div class="content">
    <div class="news">
        <div class="wrapBanner">
            <div class="banner" id="banner">
                <a class="d1" style="background:url('../front/images/banner2 (2).jpg') no-repeat center;background-size: cover;">
                    <div class="des"><span>找工作上JOB365</span></div>
                </a>
                <a class="d1" style="background:url('../front/images/banner2 (1).jpg') no-repeat center;background-size: cover;">
                    <div class="des"><span>找工作上JOB365</span></div>
                </a>
                <a class="d1" style="background:url('../front/images/banner2 (2).jpg') no-repeat center;background-size: cover;">
					<div class="des"><span>找工作上JOB365</span></div>
                </a>
                <a class="d1" style="background:url('../front/images/banner2 (1).jpg') no-repeat center;background-size: cover;">
					<div class="des"><span>找工作上JOB365</span></div>
                </a>
                <a class="d1" style="background:url('../front/images/banner2 (2).jpg') no-repeat center;background-size: cover;">
					<div class="des"><span>找工作上JOB365</span></div>
                </a>
                <div class="d2" id="banner_id">
                    <div class="ss">
                        <ul>
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                            <li></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="activity">
        <a href=""><img src="../front/images/at_1.png" alt=""></a>
        <a href=""><img src="../front/images/at_2.png" alt=""></a>
        <a href=""><img src="../front/images/at_3.png" alt=""></a>
        <a href=""><img src="../front/images/at_4.png" alt=""></a>
        <a href="" class="aRight"><img src="../front/images/at_5.png" alt=""></a>
    </div>
    <div class="platform">
        <a href=""><img src="../front/images/pl_1.png" alt=""></a>
        <a href=""><img src="../front/images/pl_2.png" alt=""></a>
        <a href=""><img src="../front/images/pl_3.png" alt=""></a>
        <a href="" class="aRight"><img src="../front/images/pl_4.png" alt=""></a>
    </div>

    <div class="special">
        <div class="indexTitle"><p class="title">热门职位</p><a href="" class="more" target="_blank">更多 &gt;</a></div>
        
        <c:forEach items="${positionList }" var="position">
        <div class="splcon fl">
            <h3>${position.positionName }(${position.positionSalary})</h3>
            <p>${ position.positionDesc} </p><a href="">详情</a></div>
        
        </c:forEach>
       
			
    </div>
    <div class="link">
        <div class="linkTitle"><p class="title">友情链接</p>
            
            <a href="" class="more" target="_blank">更多 &gt;</a>
        </div>
         <div class="linkBox">
             <ul>
                 <li><a href="">拉勾网</a></li>
				 <li><a href="">拉勾网</a></li>
				 <li><a href="">拉勾网</a></li>
				 <li><a href="">拉勾网</a></li>
				 <li><a href="">拉勾网</a></li>
				 <li><a href="">拉勾网</a></li>
				 <li><a href="">拉勾网</a></li>
				 <li><a href="">拉勾网</a></li>
				 <li><a href="">拉勾网</a></li>
				 <li><a href="">拉勾网</a></li>
				 <li><a href="">拉勾网</a></li>
				 <li><a href="">拉勾网</a></li>

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
</div>
<div class="suspend">
    <ul>
        <li class="weixin"></li>
        <li class="code"></li>
        <li class="backTop"></li>
    </ul>
</div>
<div class="marker"></div>
<script type="text/javascript" src="../front/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="../front/js/banner.js"></script>
<script type="text/javascript" src="../front/js/tabs.js"></script>
<script type="text/javascript" src="../front/js/jquery.slide.js"></script>
<script type="text/javascript">
    /*轮播数据添加*/
    $(document).ready(function () {
        /*bannner数据添加*/
        var url1="http://www.shxbe.com";
		banner();
		$("#plane>li").removeClass('select');
		$("#index").addClass('select');      
        var liLen=$(".nav>ul>li").length;
        var wh=parseInt(798/liLen);
        var lsWh=(798-wh*liLen)+wh;       
        
        $(".login span").click(function () {
            $(this).addClass("select").siblings().removeClass("select");
        });
        $("#search").focus(function () {
            if ($(this).val() == "请输入关键字") {
                $(this).val("").css("color", "#666666");
            }
        });
        $("#search").blur(function () {
            if ($(this).val() == "") {
                $(this).val("请输入关键字").css("color", "#aaaaaa");
            }
        });
        $('.tab').tabs({
            switchMode: "mouseover",
            clickPanel: ".tabNav",
            clickTag: "li",
            addStyle: "cur",
            showContent: ".tabBox"
        });
        $('.link').tabs({
            switchMode: "mouseover",
            clickPanel: ".linkNav",
            clickTag: "li",
            addStyle: "cur",
            showContent: ".linkBox"
        });

        $(".backTop").click(function () {
            var speed = 200;//滑动的速度
            $('body,html').animate({scrollTop: 0}, speed);
            return false;
        });

        $('#carousel ul').carouFredSel({
            prev: '#prev',
            next: '#next',
            scroll: 1000
        });
    })

    
	function banner(){
    var bn_id = 0;
    var bn_id2= 1;
    var speed33=5000;
    var qhjg = 1;
    var MyMar33;
    $("#banner .d1").hide();
    $("#banner .d1").eq(0).fadeIn("slow");
    if($("#banner .d1").length>1)
    {
        $("#banner_id li").eq(0).addClass("nuw");
        function Marquee33(){
            bn_id2 = bn_id+1;
            if(bn_id2>$("#banner .d1").length-1)
            {
                bn_id2 = 0;
            }
            $("#banner .d1").eq(bn_id).css("z-index","2");
            $("#banner .d1").eq(bn_id2).css("z-index","1");
            $("#banner .d1").eq(bn_id2).show();
            $("#banner .d1").eq(bn_id).fadeOut("slow");
            $("#banner_id li").removeClass("nuw");
            $("#banner_id li").eq(bn_id2).addClass("nuw");
            bn_id=bn_id2;
        }

        MyMar33=setInterval(Marquee33,speed33);

        $("#banner_id li").click(function(){
            var bn_id3 = $("#banner_id li").index(this);
            if(bn_id3!=bn_id&&qhjg==1)
            {
                qhjg = 0;
                $("#banner .d1").eq(bn_id).css("z-index","2");
                $("#banner .d1").eq(bn_id3).css("z-index","1");
                $("#banner .d1").eq(bn_id3).show();
                $("#banner .d1").eq(bn_id).fadeOut("slow",function(){qhjg = 1;});
                $("#banner_id li").removeClass("nuw");
                $("#banner_id li").eq(bn_id3).addClass("nuw");
                bn_id=bn_id3;
            }
        });
        $("#banner_id").hover(
            function(){
                clearInterval(MyMar33);
            },
            function(){
                MyMar33=setInterval(Marquee33,speed33);
            }
        )
    }
    else
    {
        $("#banner_id").hide();
    }
}
</script>
</body>
</html>
