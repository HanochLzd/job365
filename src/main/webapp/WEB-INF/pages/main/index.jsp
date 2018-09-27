<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@include file="../common/taglibs.jsp" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <LINK rel="Bookmark" href="/favicon.ico"/>
    <LINK rel="Shortcut Icon" href="/favicon.ico"/>

    <title>job365后台管理系统</title>
    <script type="text/javascript">
        function logout() {
            layer.confirm('确认退出本系统吗？', function (index) {
                //跳转至登录页面
                location.href = "<%=basePath%>login/exit";
            });

        }

        function doorManage() {
            layer_show("门户模块管理", "<%=basePath%>/doorManage/doorEdit", 500, 300);
        }

        function changePassword() {
            layer_show("修改密码", "<%=basePath%>login/changePassword", 600, 400);
        }
    </script>
</head>
<body>
<header class="navbar-wrapper">
    <div class="navbar navbar-fixed-top">
        <div class="container-fluid cl">
            <a class="logo navbar-logo f-l mr-10 hidden-xs" href="<%=basePath%>login/main/index">JOB365招聘网</a>
            <a class="logo navbar-logo-m f-l mr-10 visible-xs" href="<%=basePath%>login/main/index">JOB365招聘网</a>
            <span class="logo navbar-slogan f-l mr-10 hidden-xs">后台管理系统</span>
            <span class="logo navbar-slogan f-l mr-10 hidden-xs"><span
                    style="padding:10px;font-size:20px;color:#aaa;"></span><a style="color: #fff;" href="javascript:;"
                                                                              onclick="window.location.href='http://wx.zut.umsoft.cn/service/user/xy_login?userid=${loginUser.id}&password=${loginUser.password}'"></a></span>
            <a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;">&#xe667;</a>
            <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">

                <ul class="cl">


                    <li class="dropDown dropDown_hover"><a href="#" class="dropDown_A">${LONGIN_USER.userName}<i
                            class="Hui-iconfont">&#xe6d5;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" onclick="changePassword()">修改密码</a></li>
                            <li><a href="#" >门户管理</a></li>
                            <li><a href="javascript:;" onclick="logout()">切换账户</a></li>
                            <li><a href="javascript:;" onclick="logout()">退出</a></li>
                        </ul>
                    </li>
                    <li id="Hui-skin" class="dropDown right dropDown_hover"><a href="javascript:;" class="dropDown_A"
                                                                               title="换肤"><i class="Hui-iconfont"
                                                                                             style="font-size:18px">&#xe62a;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
                            <li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
                            <li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
                            <li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
                            <li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
                            <li><a href="javascript:;" data-val="orange" title="绿色">橙色</a></li>
                        </ul>
                    </li>

                    <a class="logo navbar-logo f-l mr-10 hidden-xs" href="#" style="float:right;margin-right:35px;"><i
                            class="Hui-iconfont" style="font-size:18px;padding-right:3px;">&#xe62d;</i>PC端</a>

                </ul>

            </nav>
        </div>
    </div>
</header>
<aside class="Hui-aside">

    <input runat="server" id="divScrollValue" type="hidden" value=""/>


    <div class="menu_dropdown bk_2">
        <c:forEach items="${menuList}" var="menu">
            <dl id="${menu.id}">
                <dt><i class="Hui-iconfont">${menu.menuIcon}</i>${menu.menuName}<i
                        class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                <dd>
                    <ul>
                        <c:forEach items="${menu.childMenus}" var="m">
                            <li><a _href="<%=basePath%>${m.menuUrl}" data-title="${m.menuName}"
                                   href="javascript:void(0)">${m.menuName}</a></li>
                        </c:forEach>
                    </ul>
                </dd>
            </dl>
        </c:forEach>

    </div>
</aside>

<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a>
</div>
<section class="Hui-article-box">
    <div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
        <div class="Hui-tabNav-wp">
            <ul id="min_title_list" class="acrossTab cl">
                <li class="active"><span title="我的桌面" data-href="<%=basePath%>login/welcome">我的桌面</span><em></em></li>
            </ul>
        </div>
        <div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S"
                                                  href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a
                id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a>
        </div>
    </div>
    <div id="iframe_box" class="Hui-article">
        <div class="show_iframe">
            <div style="display:none" class="loading"></div>
            <iframe scrolling="yes" frameborder="0" src="<%=basePath%>login/welcome"></iframe>
        </div>
    </div>
</section>
</body>
</html>