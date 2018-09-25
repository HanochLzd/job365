<%@page import="java.net.URLDecoder" %>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@include file="../../common/taglibs.jsp" %>
<html>
<head>


    <title>企业列表</title>
</head>
<body>
<input type="hidden" id="isTotal" name="isTotal" value="${isTotal}">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> job365后台管理 <span
        class="c-gray en">&gt;</span> 企业管理<a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px"
                                             href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="text-c"> 日期范围：
        <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})" id="datemin"
               class="input-text Wdate" style="width:120px;" name="startDate">
        -
        <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})" id="datemax"
               class="input-text Wdate" style="width:120px;" name="endDate">
        <input type="text" class="input-text" style="width:250px" placeholder="请输入公司名称" id="companyName"
               name="companyName">
        <button type="button" class="btn btn-success" id="" name="search" onclick="f_getList()"><i class="Hui-iconfont">&#xe665;</i>
            搜索
        </button>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
	<span class="l">
	 <a href="javascript:;" onclick="batch_delete()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>批量删除</a>
	 <a class="btn btn-primary radius" data-title="添加企业" onclick="company_add()" href="javascript:;"><i
             class="Hui-iconfont">&#xe600;</i> 添加企业</a>
	</span>

    </div>
    <table class="table table-border table-bordered table-hover table-bg" id="companyinfo_Table">
        <thead>
        <tr class="text-c">
            <th></th>
            <th>企业名称</th>
            <th width="150">企业创始人</th>
            <th width="150">LOGO</th>
            <th width="150">企业邮箱</th>
            <th width="120">企业联系方式</th>
            <th width="150">企业地址</th>
            <th width="150">企业类型</th>
            <th width="150">企业描述</th>
            <th width="150">企业创建时间</th>
            <th width="120">企业状态</th>
            <th width="120">操作</th>
        </tr>
        </thead>

    </table>
</div>
<script type="text/javascript">


    //删除
    function companyinfo_del(obj, id) {
        layer.confirm('确认要删除吗？', function (index) {
            $.post('<%=basePath%>company/delCompany.do', {"id": id}, function (data) {
                var jsonReturn = eval("(" + data + ")");
                layer.msg(jsonReturn.msg, {icon: 6, time: 1000});
                companyinfoTable.fnDraw(true);
            });
        });
    }

    //批量删除
    function batch_delete() {
        var ids = "";
        $(":checkbox").each(function () {
            if (this.checked == true) {
                ids += this.value + ",";
            }
        });
        if (ids.length == 0) {
            layer.msg("请选择资讯信息!", {icon: 7, time: 1000});
        } else {
            layer.confirm('确认要删除吗？', function (index) {
                var url = "<%=basePath%>company/delBatch.do";
                $.post(url, {
                    "delIds": ids
                }, function (data) {
                    var jsonReturn = eval("(" + data + ")");
                    layer.msg(jsonReturn.msg, {
                        icon: 6,
                        time: 1000
                    });
                    companyinfoTable.fnDraw(true);
                });
            });
        }
    }

    //审核
    function companyinfo_shenhe(obj, id) {
        layer.confirm('是否通过审核？', function (index) {
            $.post('<%=basePath%>company/changeStatus.do', {"id": id}, function (data) {
                var jsonReturn = eval("(" + data + ")");
                companyinfoTable.fnDraw(true);
                layer.msg('审核通过!', {icon: 6, time: 1000});
            });
        });
    }

    //上架
    function companyinfo_shangjia(obj, id) {
        layer.confirm('是否发布？', function (index) {
            $.post('<%=basePath%>company/changeStatus', {"id": id}, function (data) {
                var jsonReturn = eval("(" + data + ")");
                companyinfoTable.fnDraw(true);
                layer.msg('发布成功!', {icon: 6, time: 1000});
            });
        });
    }

    //上架
    function companyinfo_xiajia(obj, id) {
        layer.confirm('是否下架？', function (index) {
            $.post('<%=basePath%>company/xiajia.do', {"id": id}, function (data) {
                var jsonReturn = eval("(" + data + ")");
                companyinfoTable.fnDraw(true);
                layer.msg('下架成功!', {icon: 6, time: 1000});
            });
        });
    }

    //添加资讯
    function company_add() {

        var url = ("<%=basePath%>company/addCompany.do");
        var index = layer.open({
            type: 2,
            title: '添加企业信息',
            content: url,
        });
        layer.full(index);
    }

    //修改资讯
    function companyinfo_edit(id) {
        var url = "<%=basePath%>company/modifyCompany.do?id=" + id;
        var index = layer.open({
            type: 2,
            title: '修改企业信息',
            content: url,
        });
        layer.full(index);
    }


    function companyinfo_show(id) {
        var url = "<%=basePath%>company/companyShow.do?id=" + id;
        var index = layer.open({
            type: 2,
            title: '资讯预览',
            content: url
        });
        layer.full(index);
    }

    //对象初始化
    var companyinfoTable;

    //页面初始化
    $(function () {


        f_getList();


    });


    function f_getList() {

        var companyName = $("#companyName").val();
        var startDate = $("#datemin").val();
        var endDate = $("#datemax").val();
        companyinfoTable = $("#companyinfo_Table").dataTable({
            "bServerSide": true,     //是否启动服务器端数据导入
            "bFilter": false,       //是否搜索栏
            "bPaginate": true,       //是否显示分页器
            "bInfo": true,           //是否显示表格的一些信息
            "bJQueryUI": false,      //是否启用JQueryUI风格
            "bLengthChange": true,   //是否显示每页大小的下拉框
            "sPaginationType": "full_numbers", //分页样式
            "sServerMethod": "POST",
            "bDestroy": true,
            "sAjaxSource": "<%=basePath%>company/getCompanyListJson.do", //请求数据的URL
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
                    "mData": "companyName",
                    "mRender": function (a, b, c, d) {
                        return '<u style="cursor:pointer" class="text-primary" onClick="companyinfo_show(' + c.id + ')" title="预览" value="">' + c.companyName + '</u>';
                    }
                },
                {
                    "aTargets": [2],   //第3列
                    "mData": "userId"

                },
                {
                    "aTargets": [3],   //第4列
                    "mData": "companyLogo",
                    "mRender": function (a, b, c, d) {
                        return '<u style="cursor:pointer" class="text-primary" onClick="companyinfo_show(' + c.id + ')" title="预览" value="">' + c.companyTitle + '</u>';
                    }
                },
                {
                    "aTargets": [4],   //第5列
                    "mData": "email",
                    "mRender": function (a, b, c, d) {
                        return '<center>' + a + '</center>';
                    }
                },

                {
                    "aTargets": [5],   //第5列
                    "mData": "phone"

                },
                {
                    "aTargets": [6],   //第5列
                    "mData": "address"

                },


                {
                    "aTargets": [7],   //第5列
                    "mData": "type"

                },

                {
                    "aTargets": [8],   //第5列
                    "mData": "companyDesc"

                },

                {
                    "aTargets": [9],   //第5列
                    "mData": "companyCreateDate"

                },


                {
                    "aTargets": [10],   //第7列
                    "mData": "status",
                    "mRender": function (a, b, c, d) {

                        if (c.status == 0) {
                            return "<center><span class='label label-defaunt radius'>未审核</span></center>";
                        } else if (c.status == 1) {
                            return "<center><span class='label label-defaunt radius'>未发布</span></center>";
                        } else {
                            return "<center><span class='label label-success radius'>已发布</span></center>";
                        }
                    }
                },
                {
                    "aTargets": [11],   //第9列
                    "mRender": function (a, b, c, d) {
                        if (c.status == 1) {
                            return '<center><a title="审核" href="javascript:;" onclick="companyinfo_shenhe(this,' + c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe602;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
                                + '<a title="删除" href="javascript:;" onclick="companyinfo_del(this,' + c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
                                + '<a title="编辑" href="javascript:;" onclick="companyinfo_edit(' + c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a></center>';
                        } else {
                            if (c.status == 0) {
                                return '<center>&nbsp;<a style="text-decoration:none" onClick="companyinfo_shangjia(this,' + c.id + ')" href="javascript:;" title="发布"><i class="Hui-iconfont">&#xe603;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
                                    + '<a title="删除" href="javascript:;" onclick="companyinfo_del(this,' + c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
                                    + '<a title="编辑" href="javascript:;" onclick="companyinfo_edit(' + c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a></center>';
                            } else {
                                return '<center>&nbsp;<a style="text-decoration:none" onClick="companyinfo_xiajia(this,' + c.id + ')" href="javascript:;" title="下架"><i class="Hui-iconfont">&#xe6de;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
                                    + '<a title="删除" href="javascript:;" onclick="companyinfo_del(this,' + c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>&nbsp;&nbsp;&nbsp;&nbsp;'
                                    + '<a title="编辑" href="javascript:;" onclick="companyinfo_edit(' + c.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a></center>';
                            }
                            ;
                        }
                        ;
                    }
                },
            ],
            "fnServerParams": function (aoData) {
                aoData.push(
                    {"name": "startDate", "value": startDate},   //自定义参数
                    {"name": "endDate", "value": endDate},
                    {"name": "company.companyName", "value": companyName}
                );
            }

        });
    }
</script>
</body>
</html>