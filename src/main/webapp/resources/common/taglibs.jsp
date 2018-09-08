<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page isELIgnored="false"%>

<%
    String path = request.getContextPath();
    if(!path.endsWith("/")){
        path=path+"/";
    }
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    String uiPath=basePath+"resources/";
    String skinName="Aqua";
    String toolbar_bg=uiPath+"dg_ui/skins/"+skinName+"/images/buttons/panel-toolbar.jpg";
%>
<!-- H-ui的css -->
<link href="<%=uiPath%>common/h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="<%=uiPath%>common/h-ui/css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="<%=uiPath%>common/h-ui/skin/default/skin.css" id="skin" rel="stylesheet" type="text/css" />
<link href="<%=uiPath%>common/h-ui/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=uiPath%>common/h-ui/css/H-ui.login.css" rel="stylesheet" type="text/css" />
<link href="<%=uiPath%>common/h-ui/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=uiPath%>common/lib/Hui-iconfont/1.0.7/iconfont.css" rel="stylesheet" type="text/css" />
<!-- ztree的css -->
<%-- <link href="<%=uiPath%>common/zTree/css/demo.css" rel="stylesheet" type="text/css" />
<link href="<%=uiPath%>common/zTree/css/zTreeStyle.css" rel="stylesheet" type="text/css" /> --%>
<!-- 对话框的css -->
<link href="<%=uiPath%>common/lib/layer/skin/layer.css" rel="stylesheet" type="text/css" />
<link href="<%=uiPath%>common/lib/layer/skin/layer.ext.css" rel="stylesheet" type="text/css" />
<!-- iCkeck的css -->
<link href="<%=uiPath%>common/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
<!-- bootstrap switch 的css -->
<link href="<%=uiPath%>common/lib/bootstrap-Switch/bootstrapSwitch.css" rel="stylesheet" type="text/css"/>

<link href="<%=uiPath%>common/lib/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css"/>
<%-- <link href="<%=uiPath%>common/lib/lightbox2/2.8.1/css/lightbox.css" rel="stylesheet" type="text/css"/> --%>

<!-- jquery的js  -->
<script type="text/javascript" src="<%=uiPath%>common/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/jquery/1.9.1/jquery.validate.min.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/jquery/1.9.1/additional-methods.min.js"></script>
 <script type="text/javascript" src="<%=uiPath%>common/lib/jquery/1.9.1/validate-methods.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/jquery/1.9.1/messages_zh.min.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/jquery/1.9.1/jQuery.textSlider.js"></script>

<script type="text/javascript" src="<%=uiPath%>common/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/zTree/js/jquery.ztree.excheck.min.js"></script>

<!-- 对话框的js -->
<script type="text/javascript" src="<%=uiPath%>common/lib/layer/js/layer.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/layer/js/layer.ext.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/laypage/1.2/laypage.js"></script>
<%-- <script type="text/javascript" src="<%=uiPath%>common/lib/lightbox2/2.8.1/js/lightbox-plus-jquery.min.js"></script> --%>



<!-- H-ui的js -->
<script type="text/javascript" src="<%=uiPath%>common/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/h-ui/js/H-ui.admin.js"></script>

<!-- bootstrap modal  模态框的js -->
<script type="text/javascript" src="<%=uiPath%>common/lib/bootstrap-modal/2.2.4/bootstrap-modal.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/bootstrap-modal/2.2.4/bootstrap-modalmanager.js"></script>
<!-- bootstrap switch 的js -->
<script type="text/javascript" src="<%=uiPath%>common/lib/bootstrap-Switch/bootstrapSwitch.js"></script>
<!-- datatables的js -->
<script type="text/javascript" src="<%=uiPath%>common/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<!-- icheck 的js -->
<script type="text/javascript" src="<%=uiPath%>common/lib/icheck/jquery.icheck.min.js"></script>
<!-- datepicker的js -->
<script type="text/javascript" src="<%=uiPath%>common/lib/My97DatePicker/calendar.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/My97DatePicker/lang/en.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/My97DatePicker/lang/zh-cn.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/My97DatePicker/lang/zh-tw.js"></script>

<!-- vilidform的js -->
<script type="text/javascript" src="<%=uiPath%>common/lib/Validform/5.3.2/passwordStrength-min.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/Validform/5.3.2/Validform.min.js"></script>
<!-- 图片插件 -->
<script type="text/javascript" src="<%=uiPath%>common/lib/webuploader/0.1.5/webuploader.min.js"></script>
<!-- echarts的js -->
<script type="text/javascript" src="<%=uiPath%>common/echarts/echarts.js"></script>
<!-- ueditor的js -->
<script type="text/javascript" src="<%=uiPath%>common/lib/ueditor/utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript" src="<%=uiPath%>common/lib/ueditor/utf8-jsp/ueditor.all.min.js"></script>

