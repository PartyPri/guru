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

  //like button and comment button focus on click
  $('.fa-hand-peace-o').click(function() {
    $(this).toggleClass('media-engagement-icon-on');
  });
  $('.fa-comment-o').click(function() {
    $(this).toggleClass('media-engagement-icon-on');
  });

  //comments - if textarea empty hide submit button
  var checkText = function(){
    $(".new_comment").each(function(index){
       if($(this).find(".comment-form-textbox").val().trim().length === 0){
         $(this).find(".btn").hide();
       }else{
         $(this).find(".btn").show();
       }
     });
   };
   //comments - show submit button on key up
  $(".fa-comment-o").click( checkText() );
  $(".comment-form-textbox").keyup( function() { checkText(); });

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
