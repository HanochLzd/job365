/**
 * Created by chaoxing on 2016/12/27.
 */
$("#percent1").myProgress({speed: 1000, percent: 30, width: "70px", height: "28px"});
$("#percent2").myProgress({speed: 1000, percent: 0, width: "70px", height: "28px"});
$("#percent3").myProgress({speed: 1000, percent: 0, width: "70px", height: "28px"});
$("#percent4").myProgress({speed: 1000, percent: 10, width: "70px", height: "28px"});
$("#percent5").myProgress({speed: 1000, percent: 70, width: "70px", height: "28px"});
$("#percent6").myProgress({speed: 1000, percent: 0, width: "70px", height: "28px"});
$("#percent7").myProgress({speed: 1000, percent: 30, width: "70px", height: "28px"});
$("#percent8").myProgress({speed: 1000, percent: 0, width: "70px", height: "28px"});
$(".sort .uploadDate").click(function(){
    $(this).addClass("sortCur");
    $(".sort .normal").removeClass("cur");
});
$(".sort .normal").click(function(){
    $(this).addClass("cur");
    $(".sort .uploadDate").removeClass("sortCur");
});
$(".selectCount li").click(function(e){
    var _text=$(this).text();
    $(".countCon").text(_text);
    e.stopPropagation();
});
$(".countCon").click(function(e){
    $(this).next().slideToggle();
    e.stopPropagation();
});
$(document).click(function(){
    $(".selectCount").hide();
});
$("#reslutSear").focus(function(){
    if($(this).val()=="在结果中搜索"){
        $(this).val("").css("color","#333333");
    }
});
$("#reslutSear").blur(function(){
    if($(this).val()==""){
        $(this).val("在结果中搜索").css("color","#cccccc");
    }
});
