<%@ page pageEncoding="UTF-8" %>
<%@include file="../common/taglibs.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <%--<!-- ZUI 标准版压缩后的 CSS 文件 -->--%>
    <%--<link rel="stylesheet" href="resources/common/zui/css/zui.min.css">--%>

    <%--<!-- ZUI Javascript 依赖 jQuery -->--%>
    <%--<script src="resources/common/zui/lib/jquery/jquery.js"></script>--%>
    <%--<!-- ZUI 标准版压缩后的 JavaScript 文件 -->--%>
    <%--<script src="resources/common/zui/js/zui.min.js"></script>--%>
    <title>我的桌面</title>
</head>
<script type="text/javascript">
    $(function () {
        $("#mix_report").show();
        getSysInfo();
    });
    require.config({
        paths: {

            echarts: '<%=basePath%>resources/common/echarts'
        }
    });
    require([
        'echarts',
        'echarts/chart/bar',// 使用柱状图就加载bar模块，按需加载
        'echarts/chart/line',
        'echarts/chart/pie'
    ]),
        option = {
            title: {
                text: '系统信息统计',
                x: 'center'
            },

            tooltip: {
                trigger: 'item',
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {show: true},
                    dataView: {show: true, readOnly: false},
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
            calculable: true,
            legend: {
                orient: 'vertical',
                x: '350px',
                y: '50px',
                data: []
            },

            series: [
                {
                    name: '信息统计',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '50%'],
                    data: []
                }
            ]

        };

    /* 统计一周信息 */
    sysInfoByWeekOption = {
        title: {
            text: '系统信息统计',
            x: 'center'
        },

        tooltip: {
            trigger: 'axis'
        },
        toolbox: {
            show: true,
            y: 'top',
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        calculable: true,
        legend: {

            x: '200px',

            data: ['资讯库', '公告库', '捐赠人数', '招聘职位']
        },
        xAxis: [
            {
                type: 'category',
                splitLine: {show: false},
                data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
                "axisLabel": {
                    interval: 0
                }
            }
        ],
        yAxis: [
            {
                type: 'value',
                splitArea: {show: true}
            }
        ],
        series: []
    } ,
        /* 统计一月信息 */
        sysInfoByMonthOption = {
            title: {
                text: '系统信息统计',
                x: 'center'
            },

            tooltip: {
                trigger: 'axis'
            },
            toolbox: {
                show: true,
                y: 'top',
                feature: {
                    mark: {show: true},
                    dataView: {show: true, readOnly: false},
                    magicType: {show: true, type: ['line', 'bar']},
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
            calculable: true,
            dataZoom: {
                show: true,
                start: 0,
                end: 60
            },
            legend: {

                x: '200px',

                data: ['资讯库', '公告库', '捐赠人数', '招聘职位']
            },
            xAxis: [
                {
                    type: 'category',
                    splitLine: {show: false},
                    data: [],
                    "axisLabel": {
                        interval: 0
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    splitArea: {show: true}
                }
            ],
            series: []
        },
        /* 统计一年信息 */
        sysInfoByYearOption = {
            title: {
                text: '系统信息统计',
                x: 'center'
            },

            tooltip: {
                trigger: 'axis'
            },
            toolbox: {
                show: true,
                y: 'top',
                feature: {
                    mark: {show: true},
                    dataView: {show: true, readOnly: false},
                    magicType: {show: true, type: ['line', 'bar']},
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
            calculable: true,
            legend: {

                x: '200px',

                data: ['资讯库', '公告库', '捐赠人数', '招聘职位']
            },
            xAxis: [
                {
                    type: 'category',
                    splitLine: {show: false},
                    data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
                    "axisLabel": {
                        interval: 0
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    splitArea: {show: true}
                }
            ],
            series: []
        };

    /* 统计系统信息总数 */
    function getSysInfo() {
        $.getJSON("<%=basePath%>main/getSysInfo.do", function (data) {
            var myChart = require('echarts').init(document.getElementById('mix_report'));
            if (data == null || data == '') {
                myChart.showLoading({
                    text: "暂无数据",
                    effect: 'bubble',
                    textStyle:
                        {
                            fontSize: 10
                        }
                });
            }
            var Data = data;
            option.series[0].data = Data;
            option.legend.data = Data;
            myChart.setOption(option);
        });

    };

    /* 根据时间统计系统信息 */
    function getInfoByTime(id) {

        $.getJSON("<%=basePath%>main/getInfoByTime.do", {id: id}, function (data) {
            var myChart = require('echarts').init(document.getElementById('mix_report'));
            if (data == null || data == '') {
                myChart.showLoading({
                    text: "暂无数据",
                    effect: 'bubble',
                    textStyle:
                        {
                            fontSize: 10
                        }
                });
            }
            var Data = data;
            option.series[0].data = Data;
            option.legend.data = Data;
            myChart.setOption(option);
        });
    }

    /* 统计一周的系统信息 */
    function getInfoByWeek() {
        $.getJSON("<%=basePath%>main/getInfoByWeek.do", function (data) {
            var myChart = require('echarts').init(document.getElementById('mix_report'));
            if (data == null || data == '' || data.series == null || data.series == '') {
                myChart.showLoading({
                    text: "暂无数据",
                    effect: 'bubble',
                    textStyle:
                        {
                            fontSize: 10
                        }
                });
            }
            sysInfoByWeekOption.series = data.series;
            myChart.setOption(sysInfoByWeekOption);
        });

    }

    /* 统计一个月的系统信息 */
    function getInfoByMonth() {
        $.getJSON("<%=basePath%>main/getInfoByMonth.do", function (data) {
            var myChart = require('echarts').init(document.getElementById('mix_report'));
            if (data == null || data == '' || data.series == null || data.series == '') {
                myChart.showLoading({
                    text: "暂无数据",
                    effect: 'bubble',
                    textStyle:
                        {
                            fontSize: 10
                        }
                });
            }
            sysInfoByMonthOption.series = data.series;
            sysInfoByMonthOption.xAxis[0].data = data.xAxis;
            myChart.setOption(sysInfoByMonthOption);
        });
    }

    function getInfoByYear() {
        $.getJSON("<%=basePath%>main/getInfoByYear.do", function (data) {
            var myChart = require('echarts').init(document.getElementById('mix_report'));
            if (data == null || data == '' || data.series == null || data.series == '') {
                myChart.showLoading({
                    text: "暂无数据",
                    effect: 'bubble',
                    textStyle:
                        {
                            fontSize: 10
                        }
                });
            }
            sysInfoByYearOption.series = data.series;
            myChart.setOption(sysInfoByYearOption);
        });
    }

    function getComeOn(oSelect) {
        var id = oSelect.value;
        if (id == 1) {
            getSysInfo();
        }
        else if (id == 4) {
            getInfoByWeek();
        }
        else if (id == 5) {
            getInfoByMonth();
        }
        else if (id == 6) {
            getInfoByYear();
        }
        else {
            getInfoByTime(id);
        }

    }
</script>

<body>

<c:if test="${LONGIN_USER_ROLE eq 'admin'}">

    <div class="page-container">
        <!-- <p class="f-20 text-success">欢迎使用校友 <span class="f-14">v2.4</span>后台管理！</p> -->
        <!-- 	<p>登录次数：18 </p> -->
        <p align="right">用户名：${LONGIN_USER.userName }</p>
        <table class="table table-border table-bordered table-bg">
            <thead>
            <tr>
                <th colspan="7" scope="col">系统信息统计</th>
            </tr>
            <tr class="text-c">
                <th>统计</th>
                <th>资讯库</th>
                <th>图片库</th>
                <th>公告库</th>
                <th>捐赠人数</th>
                <th>招聘职位</th>
            </tr>
            </thead>
            <tbody>
            <tr class="text-c">
                <td>总数</td>
                <td>${desktopMap.countNews }</td>
                <td>${desktopMap.countImage }</td>
                <td>${desktopMap.countAnno }</td>
                <td>${desktopMap.countDonate }</td>
                <td>${desktopMap.countRecruit }</td>
            </tr>

            </tbody>
        </table>
        <br>

        <div id="graphic" class="col-md-8">
            <div>
                <span class="text-primary">系统信息统计</span>
                <select id="theme-select" onChange="getComeOn(this)">
                    <option value="1">总数</option>
                    <option value="2">今天</option>
                    <option value="3">昨天</option>
                    <option value="4">本周</option>
                    <option value="5">本月</option>
                    <option value="6">本年</option>
                </select>

            </div>
        </div>

        <div id="mix_report" style="height:500px;border:0px solid #ccc;padding:0px;"></div>

        <table class="table table-border table-bordered table-bg mt-20">
            <thead>
            <tr>
                <th colspan="6" scope="col">有关招聘最新动态</th>
            <tr>
            <tr class="text-c">
                <th>职务</th>
                <th>学历</th>
                <th>工作经验</th>
                <th>工作城市</th>
                <th>联系人</th>
                <th>联系电话</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach items="${RecruitList}" var="recruit">
                <tr class="text-c">
                    <td>${recruit.position}</td>
                    <td>${recruit.edu}</td>
                    <td>${recruit.experience}</td>
                    <td>${recruit.workCity}</td>
                    <td>${recruit.connect}</td>
                    <td>${recruit.phone}</td>
                </tr>
            </c:forEach>
            </tbody>

        </table>
    </div>

    <br><br><br>
    <footer class="footer mt-20">
        <div class="container">
            <p>@Copyright CX 12TH</p>
        </div>
    </footer>

</c:if>
</body>
</html>