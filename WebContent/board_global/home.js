$(function(){

    $(".gnb>li").hover(function(){
        $(this).children(".submenu_list").stop().slideDown();
    },function(){
        $(this).children(".submenu_list").stop().slideUp();
    })

})