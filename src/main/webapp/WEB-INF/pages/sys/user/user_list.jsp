<%@ page pageEncoding="UTF-8" %>
<%@include file="../../common/taglibs.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>用户列表</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <script type="text/javascript">

        var deptId = 0;

        var i = 1;
        var userTable;
        $(function () {


            userTable = $("#user_table").dataTable({
                "bServerSide": true,     //是否启动服务器端数据导入
                "bFilter": false,       //是否搜索栏
                "bPaginate": true,       //是否显示分页器
                "bInfo": true,           //是否显示表格的一些信息
                /*  "bSort" : true,          //是否可以排序 */
                "bJQueryUI": false,      //是否启用JQueryUI风格
                "bLengthChange": true,   //是否显示每页大小的下拉框
                "sPaginationType": "full_numbers", //分页样式
                "sAjaxSource": "<%=basePath%>user/getUserList", //请求数据的URL
                "bProcessing": true,	 //DataTables载入数据时，是否显示‘进度’提示
                "aoColumnDefs": [
                    {
                        "aTargets": [0],   //第1列
                        "mData": "id",
                        "mRender": function (a, b, c, d) {
                            return '<input type="checkbox" id="' + a + '" value="' + a + '" >';
                        }
                    },
                    {
                        "aTargets": [1],   //第2列
                        "mData": "userName"
                    },
                    {
                        "aTargets": [2],   //第3列
                        "mData": "realName"
                    },


                    {
                        "aTargets": [3],   //第4列
                        "mData": "phone"/* ,
				        "mRender" : function(a, b, c, d){
				        	if(a == null){
				        		return "未选择";
				        	}else{
				        		return a;
				        	}
				        } */

                    },
                    {
                        "aTargets": [4],   //5列
                        "mData": "email"/* ,
				        "mRender" : function(a, b, c, d){
				        	if(a == null){
				        		return "未选择";
				        	}else{
				        		return a;
				        	}
				        } */
                    },

                    {
                        "aTargets": [5],   //第6列
                        "mData": "gender",
                        "mRender": function (a, b, c, d) {
                            if (a == 0) {
                                return '<center>' + "男" + '</center>';
                            } else {
                                return '<center>' + "女" + '</center>';
                            }
                        }

                    },
                    /* {
                       "aTargets" : [6],   //第7列
                       "mData" : "userEmail",
                       "mRender" : function(a, b, c, d){
                            if(a == null){
                                return "未填写";
                            }else{
                                return a;
                            }
                        }
                    }, */
                    {
                        "aTargets": [6],   //第8列
                        "mData": "createDate",
                        "mRender": function (a, b, c, d) {
                            return '<center>' + a + '</center>';
                        }
                    },
                    {
                        "aTargets": [7],   //第8列
                        "mData": "remark"

                    },
                    {
                        "aTargets": [8],   //第9列
                        "mData": "userStatus",
                        "mRender": function (a, b, c, d) {
                            if (a == 1) {
                                return '<center><span class="label label-success radius">已启用</span></center>';
                            } else {
                                return '<center><span class="label label-defaunt radius">已停用</span></center>';
                            }
                        }
                    },
                    {
                        "aTargets": [9],   //第10列
                        "mRender": function (a, b, c, d) {
                            if (c.userStatus == 1) {
                                return '<center><a style="text-decoration:none" onClick="user_stop(this,' + c.id + ')" href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;' +
                                    '<a title="编辑" href="javascript:;" onclick="user_edit(' + c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>&nbsp;&nbsp;' +
                                    '<a title="删除" href="javascript:;" onclick="user_del(this,' + c.id + ',' + c.userStatus + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>&nbsp;&nbsp;' +
                                    '<a title="赋角色" href="javascript:;" onclick="user_role(' + c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe62d;</i></a></center>';
                            } else {
                                return '<center><a style="text-decoration:none" onClick="user_start(this,' + c.id + ')" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe6e1;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;' +
                                    '<a title="编辑" href="javascript:;" onclick="user_edit(' + c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>&nbsp;&nbsp;' +
                                    '<a title="删除" href="javascript:;" onclick="user_del(this,' + c.id + ',' + c.userStatus + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>&nbsp;&nbsp;' +
                                    '<a title="赋角色" href="javascript:;" onclick="user_role(' + c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe62d;</i></a></center>';
                            }
                        }
                    }
                ],
                "fnServerParams": function (aoData) {
                    aoData.push(
                        {"name": "deptId", "value": deptId}   //自定义参数
                    );
                }
            });
        });

        function user_role(id) {
            parent.id = id;
            var url = "<%=basePath%>user/userRole?id=" + id;
            layer_show("赋角色", url, 400, 400);
        }

        //添加
        function user_add(title, url) {
            /* //先清除已打开的同一个页面
            removeIframeById("module_image_add");
            creatIframe(url,"添加图片信息","module_image_add"); */

            var index = layer.open({
                type: 2,
                title: '添加图片信息',
                content: url
            });
            layer.full(index);
        }


        /*用户-停用*/
        function user_stop(obj, id) {
            layer.confirm('确认要禁用此用户吗？', function (index) {
                var url = "<%=basePath%>user/modifyUserStatus";
                $.post(url, {"id": id}, function (data) {
                    var jsonReturn = eval("(" + data + ")");
                    if (jsonReturn.msg == "1") {
                        userTable.fnDraw(true);//true停留在当前页，false返回第一页
                        //alert("jinyongchengogng ");
                        layer.msg('禁用成功!', {icon: 6, time: 2000});

                    } else if (jsonReturn.msg == "-1") {
                        layer.msg('无法禁用当前用户！', {icon: 5, time: 1000});
                    } else {
                        layer.msg('禁用失败！', {icon: 5, time: 1000});
                    }
                });
            });
        }

        /*用户-启用*/
        function user_start(obj, id) {

            layer.confirm('确认要启用此用户吗？', function (index) {
                var url = "<%=basePath%>user/modifyUserStatus";
                $.post(url, {"id": id}, function (data) {
                    var jsonReturn = eval("(" + data + ")");
                    if (jsonReturn.msg == "1") {
                        userTable.fnDraw(true);
                        layer.msg('启用成功!', {icon: 6, time: 1000});
                    } else {
                        layer.msg('启用失败!', {icon: 5, time: 1000});
                    }
                });
            });
        }


        function user_edit(id) {

            var url = "<%=basePath %>user/modifyUser.do?id=" + id;
            /* removeIframeById("active_edit_"+id);
            creatIframe(url,"修改校友风采信息","active_edit_"+id); */
            var index = layer.open({
                type: 2,
                title: '修改用户信息',
                content: url
            });
            layer.full(index);
        }


        /*用户-删除*/
        function user_del(obj, id, userStatus) {
            if (userStatus === 1) {
                layer.msg('该用户正在使用，无法删除！', {icon: 5, time: 1000});
            } else {
                layer.confirm('确认要删除吗？', function (index) {
                    var url = "<%=basePath%>user/delUser.do";
                    $.post(url, {"id": id}, function (data) {
                        var jsonReturn = eval("(" + data + ")");
                        layer.msg(jsonReturn.msg, {icon: 6, time: 1000});
                        userTable.fnDraw(true);
                    });
                });
            }
        }

        function batch_delete() {
            var ids = "";
            $(":checkbox").each(function () {
                if (this.checked == true) {
                    ids += this.value + ",";
                }
            });
            if (ids.length == 0) {
                layer.msg("请选择用户!", {icon: 7, time: 1000});
            } else {
                layer.confirm('确认要删除吗？', function (index) {
                    var url = "<%=basePath%>user/batchDeleteUser.do";
                    $.post(url, {"ids": ids}, function (data) {
                        var jsonReturn = eval("(" + data + ")");
                        layer.msg(jsonReturn.msg, {
                            icon: 1,
                            time: 1000
                        });
                        userTable.fnDraw(true);
                    });
                });
            }
        }
    </script>
</head>

<body>

<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理<span
        class="c-gray en">&gt;</span> 用户管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px"
                                              href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onclick="batch_delete()"
                                                                class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
	 <a href="javascript:;" onclick="user_add('添加图片信息','<%=basePath %>user/addUser.do')" class="btn btn-primary radius"><i
             class="Hui-iconfont">&#xe600;</i> 添加用户</a></span></div>
    <div class="mt-20">
        <table id="user_table" class="table table-border table-bordered table-hover table-bg table-sort">
            <thead>
            <tr class="text-c">
                <th width="25"><input type="checkbox" value="" name=""></th>
                <th width="150">用户名</th>
                <th width="150">真实姓名</th>
                <th width="150">电话</th>
                <th width="250">邮箱</th>
                <th width="80">性别</th>
                <th width="150">创建时间</th>
                <th width="120">描述</th>
                <th width="120">状态</th>
                <th width="120">操作</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
</div>
</body>
</html>
