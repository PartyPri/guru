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

//stick reel navigation right under main nav on scroll
$(window).scroll(function() {
  var scrollPos = $(this).scrollTop();
  var scrollStick = $(".reel-header-container").outerHeight();
  var stickyCta = $('.reel-sticky-cta-bg');
  if ( scrollPos > scrollStick ){
      stickyCta.addClass("stick");
    }
    else{
      stickyCta.removeClass("stick");
    }
});

//Reel page view options
$(document).ready(function() {

  //share button function
  // $('.share-circle').click(function() {
  //   $('.share-button').css({opacity: 1.0, visibility: "visible"}).animate({opacity: 0}, 200);
  //   $('#links').css({opacity: 0}).animate({opacity: 1.0, height: '30px'}, 400);
  // });
  // $('.share-button-mobile').click(function() {
  //   $('.share-button-mobile').css({opacity: 1.0, visibility: "visible"}).animate({opacity: 0}, 200);
  //   $('.link-item-mobile').css('z-index', 0);
  // })

  //expanding comments
  $('.comment-btn-expand').click(function(event) {
    var commentId = event.target.id;
    console.log(commentId);
    $('#comments-id-' + commentId).toggleClass('hidden');
  });

  //viewing options
  $(".reel-view-item").on('click', function() {
    var ref = $(this).text().trim();

    //Highlights active view option
    $(this).parent().find('.reel-view-item').css('border-bottom', 'none');
    $(this).css('border-bottom', 'solid #10BBA7');

    //scroll down if in header
    var scrollTo = $(".reel-header-container").outerHeight();
    if($(window).scrollTop() < scrollTo){
      $('html, body').animate({scrollTop: scrollTo + 1}, 'slow');
    }else{
      console.log("you're not in the header");
    }
  });
});
