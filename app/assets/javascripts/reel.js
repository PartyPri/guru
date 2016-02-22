$(function() {
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

$(document).ready(function() {
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

  //like button and comment button focus on click
  $('.fa-hand-peace-o').click(function() {
    $(this).toggleClass('media-comments-icon-on');
  });
  $('.fa-comment-o').click(function() {
    $(this).toggleClass('media-comments-icon-on');
  });

  //scrolling to and expanding comments
  $('.comment-btn-expand').click(function(event) {
    var commentId = event.target.id;
    $('#comments-id-' + commentId).toggleClass('hidden');
    $('html, body').animate({
      scrollTop: $('#comments-id-' + commentId).offset().top - 150
    }, 500);
  });

  //comments - if textarea empty hide submit button
  var checkText = function(){
    $(".new_comment").each(function(index){
       if($(this).find("textarea").val().trim().length === 0){
         $(this).find(".btn").hide();
       }else{
         $(this).find(".btn").show();
       }
     });
   };
   //comments - show submit button on key up
  $(".fa-comment-o").click( checkText() );
  $("textarea").keyup( function() { checkText(); });

  //reel - viewing options
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
