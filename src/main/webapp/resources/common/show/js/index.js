// 顶部轮播
var swiper = new Swiper('.auto_swiper .swiper-container', {
    pagination                      : '.auto_swiper .swiper-pagination',
    slidesPerView                   : 1,
    autoplay                        : 3000,
    autoplayDisableOnInteraction    : false,
    loop                            : true,
    prevButton						: '.swiper-button-prev',
	nextButton						: '.swiper-button-next',
});
// 推广轮播
var swiper = new Swiper('.extension_swiper .swiper-container', {
    pagination                      : '.extension_swiper .swiper-pagination',
    slidesPerView                   : 1,
    autoplay                        : 3000,
    autoplayDisableOnInteraction    : false,
    loop                            : true,
    prevButton						: '.swiper-button-prev',
	nextButton						: '.swiper-button-next',
});
$(function(){
	var _time = new Date();  															// 时间标志 防止滑动过快
	$('.nav li').mouseenter(function(){													// 鼠标进入导航栏
		if( new Date() - _time > 100){	
			$(this).find('.second_nav').slideDown();									// 二级导航栏显示
			$(this).siblings('li').find('.second_nav').slideUp();						// 一级导航栏的兄弟节点的二级导航栏隐藏
			$(this).parent('.nav').siblings('.nav').find('.second_nav').slideUp();		// 一级导航栏的兄弟节点的二级导航栏隐藏
			_time = new Date();															// 重新标志时间
		}
	});

	$('.header_nav').mouseleave(function() {											// 鼠标从一级导航栏离开
		$('.second_nav').slideUp();														// 二级导航栏隐藏
	});
	$('.header_nav .second_nav').mouseleave(function() {								// 鼠标离开导航栏
		if( new Date() -_time > 100){
			$('.second_nav').slideUp();													// 二级导航栏隐藏
			_time = new Date();
		}
	});
})