/**
 * Created by zhenzhen on 2017/1/17/017.
 */
$(document).ready(function(){
    /*bannner数据添加*/
    var url1="http://www.shxbe.com";
    $.ajax({
        type: "get",
        url: "shxbe.chaoxing.com/front/localNews/newsList?nodeid=3256&curPage=1&pageSize=10",
        dataType: "json",
        success: function(data){
            if (data.list!=undefined&&data.list!=null&data.list!=''){
                var bnr=$('<div class="banner" id="banner"></div>');
                var d2=$(' <div class="d2" id="banner_id"> <div class="ss"> <ul></ul></div></div>');

                var bnrData=data.list;
                console.log(bnrData.length);
                for (var i=0;i<bnrData.length;i++){
                    bnr.append(' <a class="d1" style="background:url('+url1+bnrData[i].preview+') no-repeat center;background-size: 100% 100%;"><div class="des"><span>'+bnrData[i].title+'</span></div></a>');
                    $("ul",d2).append('<li></li>');
                }
                bnr.append(d2);
                $(".wrapBanner").append(bnr);
                banner();
            }
        }
    });

    /*通知公告 4963*/
    function news(nodeid){
        $.ajax({
            type: "get",
            url: "http://shxbe.chaoxing.com/front/localNews/news?nodeid="+nodeid+"&curPage=1&pageSize=9",
            dataType: "json",
            success: function(data){
                if (data.list!=undefined&&data.list!=null&data.list!=''){
                    var inform=data.list;
                    var tabBox=$('<div class="tabBox" style="display: none"><ul></ul><a href="" class="more">更多></a></div>');
                    for (var i=0;i<inform.length;i++){
                        $("ul",tabBox).append(' <li><a href="">'+inform[i].source+'</a></li>')
                    }
                    $(".tab").append(tabBox);
                    $(".tabBox").eq(0).show();
                }
            }
        });
    }
    news(4963);news(4964);
    /*setTimeout(function(){ news(4964);},500);*/

    /*专题专栏*/
    $.ajax({
        type: "get",
        url: "http://shxbe.chaoxing.com/front/localNews/news?nodeid=79345&curPage=1&pageSize=5",
        dataType: "json",
        success: function(data){
            if (data.list!=undefined&&data.list!=null&data.list!=''){
                var splData=data.list;
                for (var i=0;i<splData.length;i++){
                    $(".special").append('<div class="splcon fl">'+ '<img src="'+url1+splData[i].preview+'" alt="">'+ '<h3>'+splData[i].title+'</h3>'+ '<p>'+splData[i].source+'</p><a href="">[阅读]</a> </div>');
                }
                $(".splcon").eq(splData.length-1).addClass("splRight");
            }else{
                $(".special").append('<p>暂无数据</p>');
            }
        }
    });

    /*友情链接 5724*/
    function linkType(nodeid){
        $.ajax({
            type: "get",
            url: "http://shxbe.chaoxing.com/front/localNews/news?nodeid="+nodeid+"&curPage=1&pageSize=18",
            dataType: "json",
            success: function(data){
                if (data.list!=undefined&&data.list!=null&data.list!=''){
                    var linkData=data.list;
                    var linkBox=$('<div class="linkBox" style="display: none"><ul></ul></div>');
                    for (var i=0;i<linkData.length;i++){
                        $("ul",linkBox).append(' <li><a href="">'+linkData[i].title+'</a></li>')
                    }
                    $(".link").append(linkBox);
                    $(".linkBox").eq(0).show();
                }

            }
        });
    }
    linkType(5724);linkType(55023);linkType(5723);linkType(5565);

    /*交流群*/
    $.ajax({
        type: "get",
        url: "http://shxbe.chaoxing.com/front/localNews/news?nodeid=764&curPage=1&pageSize=4",
        dataType: "json",
        success: function(data){
            if(data.list!=undefined&&data.list!=null&data.list!=''){
                var qqGroup=data.list;
                var qqUl=$('<ul></ul>');
                for (var i=0;i<qqGroup.length;i++){
                    qqUl.append('<li><img src="images/group.png" alt=""><span>'+qqGroup[i].source+'</span></li>')
                }
                $(".qqGroup").append(qqUl);
            }
        }
    });
});

