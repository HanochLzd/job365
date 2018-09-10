<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/taglibs.jsp"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'user_add.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="<%=uiPath%>common/zTree/css/demo.css" rel="stylesheet" type="text/css" />
	<link href="<%=uiPath%>common/zTree/css/zTreeStyle.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
	
	ul.ztree {
    margin-top: 10px;
    border: 0;
    width: 220px;
    height: 238px;
     /* overflow-y: scroll; */
    overflow-y: auto;
    overflow-x: auto;
    background: #fff;
}


	</style>
  <script type="text/javascript">
  var roleId = ${role.id}
  
  

  var zNodes;
  var setting = {
			check: {
				enable: true
			},
			
			
			
			data: {
				simpleData: {
					enable: true
				},
				key: {
					icon: "menuIcon"
				}
			}
		};

	
		var code;
		
		function setCheck() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			py = $("#py").attr("checked")? "p":"",
			sy = $("#sy").attr("checked")? "s":"",
			pn = $("#pn").attr("checked")? "p":"",
			sn = $("#sn").attr("checked")? "s":"",
			type = { "Y":py + sy, "N":pn + sn};
			zTree.setting.check.chkboxType = type;
			showCode('setting.check.chkboxType = { "Y" : "' + type.Y + '", "N" : "' + type.N + '" };');
		}
		function showCode(str) {
			if (!code) code = $("#code");
			code.empty();
			code.append("<li>"+str+"</li>");
		}
		
		$(document).ready(function(){
			initRoleTree();
			
		});
		
		
		function initRoleTree(){
			
			$.ajax({
				type:"post",
				url:"<%=basePath%>role/getMenuById.do?id="+roleId,
				dataType:"json",
				success:function(data){
					
					$.fn.zTree.init($("#treeDemo"), setting, data);
					
				},
				error:function(data){
					alert("fail");
				}
			});
		}
		
		 //用户重新选择权限时，获取选择权限的id，此处可以拼接权限id的字符串，到后台切割成数组。String.split(",")
        function test(){
            //获取被选中的节点集合
            var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
            var nodes = treeObj.getCheckedNodes(true);
            //如果nodes的长度大于0说明ztree中有被选中的节点
            if(nodes.length>0){
                for(var i=0;i<nodes.length;i++){
                    var id=nodes[i]["id"];//获取选中节点的id
                    var name=nodes[i]["name"];//获取选中节点的名字
                    alert(id);
                    alert(name);
                }
            }else{
                alert("没有选中节点");
            }
        }
		
		function giveMenu(){
			
			  //获取被选中的节点集合
            var treeObj = $.fn.zTree.getZTreeObj("treeDemo");		
            var nodes = treeObj.getCheckedNodes(true);
            //如果nodes的长度大于0说明ztree中有被选中的节点
            var menuIds= "";
           
            if(nodes.length>0){
            
                for(var i=0;i<nodes.length;i++){
                    var id=nodes[i]["id"];//获取选中节点的id
                    var name=nodes[i]["name"];//获取选中节点的名字
                    menuIds = menuIds+","+id;                   
                  
                }
                
                alert(roleId)
                
                alert(menuIds);
                
                $.ajax({
    				type:"post",
    				url:"<%=basePath%>role/giveMenu.do?",
    				data:{"id":roleId,"menuIds":menuIds},
    				dataType:"json",
    				success:function(data){
    					
    					
    					 if(data.code == 1){
    					    	layer.alert(data.msg, {icon: 6,time:0}, function(data){
    					    			var index = parent.layer.getFrameIndex(window.name);
    								    window.parent.location.reload(true);
    									parent.layer.close(index); 
    					    		
    					    	});
    							
    					    }
    				},
    				error:function(data){
    					alert("no")
    				}
    			
    				
    			});
                
                
            	
            }else{
                alert("没有选中节点");
            }
			
			
			
		}

</script> 
  </head>
  
<body>

	<div class="center">
		<ul id="treeDemo" class="ztree"></ul>
		
	</div>
	<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<button class="btn btn-success radius" onclick="giveMenu()" ><i class="Hui-iconfont">&#xe62d;</i>授权</button>
			</div>
		</div>

</body>
</html>
