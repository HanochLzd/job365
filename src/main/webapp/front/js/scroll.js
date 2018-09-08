/**
 * Created by chaoxing on 2017/1/10.
 */
$(document).ready(function(){
    function scroll() {
        $(".informCon ul").animate({"margin-top": "-60px"}, function () {
            $(".informCon ul li:eq(0)").appendTo($(".informCon ul"));
            $(".informCon ul").css({"margin-top": 0});
        });
    }
    var myScroll = setInterval(scroll, 3000);
    $(".informCon").mouseout(function () {
        myScroll = setInterval(scroll, 3000);
    });
    $(".informCon").mouseover(function () {
        clearInterval(myScroll);
    });

    $(".big").click(function(){
        $(".article p").css("font-size","16px");
    });
    $(".middle").click(function(){
        $(".article p").css("font-size","14px");
    });
    $(".small").click(function(){
        $(".article p").css("font-size","12px");
    })
});

