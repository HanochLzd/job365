<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../common/taglibs.jsp" %>
<html>	
  <head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
    	<meta name="description" content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">
    	<meta name="author" content="Muhammad Usman">		
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<link rel="icon" href="img/favicon.ico">
		<title></title>
    	<base href="<%=basePath%>"/>

    	
    	
    	<script type="text/javascript">
    		

        $(function (){
            
          //默认加载url
    		//var defaultUrl = '${defaultUrl}';
    		//var defaultText = '${defaultText}';
    		//if('' != defaultUrl && '' != defaultText){
    			//$("#home").attr('src', defaultUrl);
    			//f_addTab(generateTabId(defaultUrl), defaultText, defaultUrl);
    		//}
            
         });
         
        
       //退出登录
       function loginOut(){
    	   $("#confirmModal").modal('show');
		   $("#modal_confirm").html('是否确定注销当前登录？');
		   $("#confirm_button").on('click',function(){			   					
				location.href = "<%=basePath%>login/loginOut.do";
		   });		      	 
       	 
       }
       
       //修改个人资料
       function personalInfoEdit(){
       		window.frame_content.location.href = "<%=basePath%>login/personalInfoEdit.do";
       		<%-- var url = "<%=basePath%>login/personalInfoEdit.do";
       		f_addTab("login_personalInfoEdit_do", "个人资料设置", url); --%>
       }
       
       
       //修改密码
       function updatePassword(){
       		window.frame_content.location.href = "<%=basePath%>login/updatePassword.do";
       		<%-- var url = "<%=basePath%>login/updatePassword.do";
       		f_addTab("login_updatePassword_do", "修改密码", url); --%>
       }
       
    	</script>
       
       <script type="text/javascript">
	
	 /*  $("#frame_content").load(function(){
	     var mainheight=$("body").height()+30;
	    
         $(this).height(mainheight);
		 })
		 $(function(){ $("#frame_content").load(function(){
var mainheight = $(this).contents().find("body").height()+30;
$(this).height(mainheight);
}); })*/
	function SetWinHeight(obj){ 
   		var win=obj; 
   		var frameid= document.getElementById('frame_content');
   
   		if (frameid){ 
      		if (win && !window.opera){ 
         		if (win.contentDocument && win.contentDocument.body.offsetHeight){ 		 
		     		win.height = win.contentDocument.body.offsetHeight+500;		     			   
         		}else if(win.Document && win.Document.body.scrollHeight){ 
            		win.height = win.Document.body.scrollHeight+500;
         		};
        	};
    	};
	}	
	 
	
</script>
  </head>
  
  
  <body style="min-width:1200px; overflow:auto;">
    	 <div class="navbar navbar-default" role="navigation">

		        <div class="navbar-inner">
			            <button type="button" class="navbar-toggle pull-left animated flip">
			                <span class="sr-only">Toggle navigation</span>
			                <span class="icon-bar"></span>
			                <span class="icon-bar"></span>
			                <span class="icon-bar"></span>
			            </button>
		            	<a class="navbar-brand"> <img alt="大数据网络敏感信息发现通报预警平台" src="<%=basePath%>resources/common/img/logo.png" class="hidden-xs"/>
		                <span></span></a>
		
		            <!-- user dropdown starts -->
		
			            <div class="btn-group pull-right">
			                <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
			                    <i class="glyphicon glyphicon-user"></i><span class="hidden-sm hidden-xs"> ${loginUser.userName }</span>
			                    <span class="caret"></span>
			                </button>
			                <ul class="dropdown-menu">
			                	<li><a href="javascript:personalInfoEdit()" >个人信息</a></li>
			                	<li class="divider"></li>
			                	<li><a href="javascript:updatePassword()">修改密码</a></li>
			                    <li class="divider"></li>
			                    <li><a href="javascript:loginOut()">注销登录</a></li>
			                    
			                </ul>
			            </div>
		            <!-- user dropdown ends -->
					
		        </div>
    	</div>
    <!-- topbar ends -->
<div class="ch-container">
    <div class="row">
        
        <!-- left menu starts -->
        <div class="col-sm-2 col-lg-2">
            <div class="sidebar-nav">
                <div class="nav-canvas">
                    <div class="nav-sm nav nav-stacked">

                    </div>
                    <ul class="nav nav-pills nav-stacked main-menu">
                        <li class="nav-header">校友管理</li>
                        <c:if test="${null != dataTreeData && ! empty dataTreeData }">
                        	<c:forEach var="dataTree" items="${dataTreeData }" >
                        		<li class="accordion">
								  <a class="ajax-link" href="#"><i class="${dataTree.menuStyle }"></i><span> ${dataTree.text}</span></a>
								  <c:if test="${null != dataTreeData && ! empty dataTreeData }">
								  	<ul class="nav nav-pills nav-stacked">
								  		<c:forEach var="dataTreeChildren" items="${dataTree.children }" >
											<li><a href="<%=basePath%>${dataTreeChildren.url}" target="frame_content">${dataTreeChildren.text }</a></li>
										</c:forEach>
								    </ul>
								  
								  </c:if>
		                           
		                        </li>
                        	</c:forEach>
                        </c:if>
						
						
                        <li class="nav-header hidden-md">系统管理</li>
                        <c:if test="${null != sysTreeData && ! empty sysTreeData }">
                        	<c:forEach var="sysTree" items="${sysTreeData }" >
                        		<li class="accordion">
								  <a class="ajax-link" href="#"><i class="${sysTree.menuStyle }"></i><span>${sysTree.text}</span></a>
								  <c:if test="${null != sysTreeData && ! empty sysTreeData }">
								  	<ul class="nav nav-pills nav-stacked">
								  		<c:forEach var="sysTreeChildren" items="${sysTree.children }" >
											<li><a href="<%=basePath%>${sysTreeChildren.url}" target="frame_content">${sysTreeChildren.text }</a></li>
										</c:forEach>
								    </ul>
								  
								  </c:if>
		                           
		                        </li>
                        	</c:forEach>
                        </c:if>
                    </ul>
                    
                </div>
            </div>
        </div>
        <!--/span-->
        <!-- left menu ends -->
        
        
				<div class="col-sm-10 col-lg-10">
		        	<iframe src="<%=basePath%>main/mainDynamic.do" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" onLoad="Javascript:SetWinHeight(this)" id="frame_content" name="frame_content"></iframe>
				</div>
        		<noscript>
		            <div class="alert alert-block col-md-12">
		                <h4 class="alert-heading">Warning!</h4>
		
		                <p>You need to have <a href="http://en.wikipedia.org/wiki/JavaScript" target="_blank">JavaScript</a>
		                    enabled to use this site.</p>
		            </div>
        		</noscript>

    
			    <footer class="row">
			        <p class="col-md-9 col-sm-9 col-xs-12 center">&copy; <a href="http://www.antai.com" target="_blank">河南省安泰信息科技有限公司</a> 2016 - 2020</p>
			
			        
			    </footer>

		</div>
</div>


	
  </body>


</html>
