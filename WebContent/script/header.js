$(document).ready(function() {
  $('#mainnav').mouseenter(function() {
    $('#subnavBG').stop().slideDown(500);
    $('#sNav').stop().show();
    $('#navStoreLink').mouseenter(function() {
    	$('#cNav').stop().hide();
    	$('#fNav').stop().hide();
    	$('#sNav').stop().show();
    });
    $('#navCommunityLink').mouseenter(function() {
    	$('#sNav').stop().hide();
    	$('#fNav').stop().hide();
    	$('#cNav').stop().show();
    });
    $('#navFundingLink').mouseenter(function() {
    	$('#sNav').stop().hide();
    	$('#cNav').stop().hide();
    	$('#fNav').stop().show();
    });
    
  });  
  $('#subnavBG').mouseleave(function() {
    $('#subnavBG').stop().slideUp(500);
  });
  
  $('#loginUser').mouseenter(function() {
      $('#userMenu').stop().slideDown(500);
  });
  $('#loginUser').mouseleave(function() {
      $('#userMenu').stop().slideUp(500);
  });
});