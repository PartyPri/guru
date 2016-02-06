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
    autocomplete_url:'/api/tags',
    messages: {
        noResults: '',
        results: function() {}
    },
    'height':'100px',
    'width':'100%',
    'interactive':true,
    'defaultText':'add a tag'
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

  //like button on click
  $('.fa-hand-peace-o').click(function() {
    $(this).toggleClass('media-comments-icon-on');
  });
  $('.fa-comment-o').click(function() {
    $(this).toggleClass('media-comments-icon-on');
  });

  //expanding comments
  $('.comment-btn-expand').click(function(event) {
    var commentId = event.target.id;
    $('#comments-id-' + commentId).toggleClass('hidden');
  });

  //if textarea empty hide submit button
  var checkText = function(){
    $(".new_comment").each(function(index){
       if($(this).find("textarea").val().trim().length === 0){
         $(this).find(".btn").hide();
       }else{
         $(this).find(".btn").show();
       }
     });
   };

  $(".fa-comment-o").click( checkText() );
  $("textarea").keyup( function() { checkText(); });

  //viewing options
  $(".reel-view-item").on('click', function() {
    var ref = $(this).text().trim();

    //Highlights active view option
    $(this).parent().find('.reel-view-item').css('border-bottom', 'none');
    $(this).css('border-bottom', 'solid #10BBA7');

    //scroll down if in header
    reelScroll();
  });

  function reelScroll(){
    var scrollTo = $(".reel-header-container").outerHeight();
    if($(window).scrollTop() < scrollTo){
      $('html, body').animate({scrollTop: scrollTo + 1}, 'slow');
    }
  }

  //credit invitation handlers
  $(".credit-invitation-footer").click(function(){
    setTimeout(function() {
      $('#credit-dropdown').addClass('open');
      reelScroll();
    });
  });
  //minimizing credit-invitation
  $(".credit-invitation-minimize").click(function () {
    if($(".credit-invitation-container").hasClass("minimize")){
      $(".credit-invitation-container").animate({ bottom: '0'}, "fast")
      $(".credit-invitation-minimize").toggleClass("fa-caret-up");
      $(".credit-invitation-minimize").toggleClass("fa-caret-down");
      $(".credit-invitation-container").toggleClass("minimize");
    }else{
      $(".credit-invitation-container").animate({ bottom: '-323'}, "fast")
      $(".credit-invitation-minimize").toggleClass("fa-caret-up");
      $(".credit-invitation-minimize").toggleClass("fa-caret-down");
      $(".credit-invitation-container").toggleClass("minimize");
    }
  });
});
