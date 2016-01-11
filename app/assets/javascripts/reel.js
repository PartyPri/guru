$(function() {
  //Only execute on facebook share pages
  if($("#fb-root").length) {
    var share_object = $("#fb-root").data("share-object");
    var fb_app_id = $("#fb-root").data("fb-app-id");

    window.fbAsyncInit = function() {
      FB.init({appId: fb_app_id, status: true, cookie: true, xfbml: true});
    };

    (function() {
      var e = document.createElement('script'); e.async = true;
      e.src = document.location.protocol +
      '//connect.facebook.net/en_US/all.js';
      document.getElementById('fb-root').appendChild(e);
    }());
  }

  // Tagging
  $('#reel_tag_list').tagsInput({
    autocomplete_url:'/api/tags'
  });
});

$(window).scroll(function() {
  var scrollPos = $(this).scrollTop();
  var scrollStick = $(".reel-header-container").outerHeight();
  var stickyCta = $('.reel-sticky-cta-bg')
  if ( scrollPos > scrollStick ){
      stickyCta.addClass("stick");
    }
    else{
      stickyCta.removeClass("stick");
    }
});
