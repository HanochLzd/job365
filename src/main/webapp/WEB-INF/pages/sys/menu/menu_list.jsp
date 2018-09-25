    <%@ page pageEncoding="UTF-8" %>
        <%@include file="../../common/taglibs.jsp" %>
        <%@ page isELIgnored="false" %>
        <html>
        <head>
        <title>权限管理</title>
        </head>
        <body>
        <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span
        class="c-gray en">&gt;</span> 权限管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px"
        href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
        <div class="page-container">
        <div class="text-c">
        <form class="Huiform" method="post" action="<%=basePath %>menu/query" target="_self">
        <c:if test="${empty menuName}">

            <input type="text" class="input-text" style="width:250px" placeholder="权限名称" name="menuName"
            value="">
        </c:if>
        <c:if test="${not empty menuName}">

            <input type="text" class="input-text" style="width:250px" placeholder="权限名称" name="menuName"
            value="${menuName}">
        </c:if>
        <button type="submit" class="btn btn-success" name=""><i class="Hui-iconfont">&#xe665;</i> 搜权限节点</button>
        </form>
        </div>
        <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onclick="batch_delete()"
        class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
        <a href="javascript:;" onclick="admin_permission_add('添加权限节点','<%=basePath %>menu/addMenu.do','','310')"
        class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加权限节点</a></span>
        <span class="r">共有数据：<strong>${menuList.size()}</strong> 条</span> </div>
        <table class="table table-border table-bordered table-bg">
        <thead>
        <tr>
        <th scope="col" colspan="7">权限节点</th>
        </tr>
        <tr class="text-c">
        <th width="25"><input type="checkbox" name="" value=""></th>
        <th width="40">ID</th>
        <th width="200">权限名称</th>
        <th>权限路径</th>
        <th width="200">权限描述</th>
        <th width="100">操作</th>
        </tr>
        </thead>
            <tbody>
            <c:forEach items="${menuList}" var="menu">
                    <tr class="text-c">
                    <td><input type="checkbox" value="${menu.id}" name="menuId" ></td>
                    <td>${menu.id}</td>
                    <td>${menu.menuName}</td>
                    <td>${menu.menuUrl}</td>
                    <td>${menu.menuDesc}</td>
                    <td><a title="编辑" href="javascript:;" onclick="admin_permission_edit('角色编辑','<%=basePath %>menu/editMenu.do','${menu.id }','','310')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除" href="javascript:;" onclick="admin_permission_del(this,'${menu.id}')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
                    <%-- 		      <td class="f-14"><a title="编辑" href="javascript:;" onclick="admin_role_edit('角色编辑','<%=basePath %>/role/edit.do','${role.id}')" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除" href="javascript:;" onclick="admin_role_del(this,'${role.id}')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
                     --%>		      </tr>
            </c:forEach>
        </table>
        </div>
        <script type="text/javascript">
        /*
        参数解释：
        title 标题
        url 请求的url
        id 需要操作的数据id
        w 弹出层宽度（缺省调默认值）
        h 弹出层高度（缺省调默认值）
        */
        /*管理员-权限-添加*/
        function admin_permission_add(title,url,w,h){
        layer_show(title,url,w,h);
        }
        /*管理员-权限-编辑*/
        function admin_permission_edit(title,url,id,w,h){
        layer_show(title,url+"?menuId="+id,w,h);
        }


        /*管理员-权限-删除*/
        function admin_permission_del(obj,id){

        layer.confirm('确认要删除吗？',function(index){
        var url = "<%=basePath%>menu/delMenu.do";
        $.post(url, {"id":id}, function(data){
        $(obj).parents("tr").remove();
        var jsonReturn = eval("(" + data +")");
        console.log(jsonReturn)
        layer.msg(jsonReturn.msg,{icon:6,time:1000});
        location.fnDraw(true);

        });

        });
        }


        /*批量删除*/

        function batch_delete(){
        var ids = "";
        $(":checkbox").each(function(){
        if(this.checked == true){
        ids += this.value + ",";
        }
        });
        if(ids.length == 0){
        layer.msg("请至少选择一行!", {icon:7, time:1000});
        }else{

        layer.confirm('确认要删除吗？',function(index){
        var url = "<%=basePath%>menu/batchDeleteMenu.do";
        $.getJSON(url,{"ids":ids},function (data){
        console.log(data)

        // console.log(json)
        layer.alert(data.msg, {icon: 6,time:0}, function(data){
        var index = parent.layer.getFrameIndex(window.name);
        window.parent.location.reload(true);
        parent.layer.close(index);

        });
        });


        /* $.post(url, {"ids" : ids }, function(data) {
        //$(obj).parents("tr").remove();
        var json = eval("(" + data + ")");
        layer.alert(json.msg, {icon: 6,time:0}, function(data){
        var index = parent.layer.getFrameIndex(window.name);
        window.parent.location.reload(true);
        parent.layer.close(index);

        });
        }); */
        });
        }
        }

        </script>
        </body>
        </html>