// $(function() {
//   //Tagging
//   $('#reel_tag_list').tagsInput({
//     autocomplete_url:'/api/tags',
//     messages: {
//         noResults: '',
//         results: function() {}
//     },
//     'height':'100px',
//     'width':'100%',
//     'interactive':true,
//     'defaultText':'add a tag'
//   });
// });

$(document).ready(function() {
  //Tagging when creating new reels
  //only call api in create new reel view
  if ($('#tag_options').length === 1){
    //function to create checkbox for each tag
    var newTagElement = function(interest, interest_id, tag){
      var tagPill = document.createElement("div");
      var tagIcon = document.createElement("i");
      var tagName = document.createTextNode(" " + tag);
      tagPill.className = "tag-disable " + escChar(interest.split(' ').join(''));
      tagIcon.className = "fa fa-tag";
      tagPill.setAttribute("value", tag);
      tagPill.appendChild(tagIcon);
      tagPill.appendChild(tagName);

      $('#tag_options').append(tagPill)
    }

    //api call to get the tags
    $.get('/api/tags', function(tags){
      tags.forEach(function(interest){
        for (var i =0; i < interest['tags'].length; i++){
          newTagElement(interest['interest'],interest['id'],interest['tags'][i]);
        }
      });
    })
      .done(function(){
        tagsInit();
      });

    //selecting and deselecting interest
    $('.interest-check').change(function(){
      var interest = escChar($(this)[0].nextSibling.nodeValue.trim().split(' ').join(''));
      $('.'+interest).toggleClass('tag-disable');
      $('.'+interest).toggleClass('tag');
      $('.'+interest).toggleClass('selectable');
      $('.'+interest).removeClass('tag-selected');
      tagSelected();
    });

    //refreshes list of available tags
    $(document).click(function(){
      //selecting and deselecting tags
      $('.selectable').click(function(){
        if($(this).hasClass('selectable')){
          $(this).toggleClass('tag-selected');
          tagSelected();
        }
      });
    });

    //enable tags based on selected interests and highlight previously selected tags
    function tagsInit(){
      var selectedInterests = [];
      var currentTags = $('#reel_tag_list').val().split(',');
      $(':checkbox:checked').each(function(){
        selectedInterests.push(escChar($(this)[0].nextSibling.nodeValue.trim().split(' ').join('')));
      })
      selectedInterests.forEach(function(interest){
        $('.'+interest).toggleClass('selectable');
        $('.'+interest).toggleClass('tag');
        $('.'+interest).toggleClass('tag-disable');
      });
      currentTags.forEach(function(tag){
        $("div[value='" + tag.trim() +"']").toggleClass('tag-selected')
      });
    }

    //set selected tags for the form
    function tagSelected(){
      var tagList = $('.tag-selected').text();
      tagList = tagList.split(" ");
      tagList = tagList.join(", ");
      $('#reel_tag_list').val(tagList.slice(2));
    }

    //escapes special characters for jquery selectors
    function escChar(string) {
        return string.replace(/[!"#$%&'()*+,.\/:;<=>?@[\\\]^`{|}~]/g, "")
    }
  }

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

  //minimize credit sidebar
  $(".reel-credit-header").click(function(){
    $(".reel-credit-list").toggleClass("reel-credit-list-min");
    $("#credit-list-close").toggleClass("hidden");
    $(".section-media").toggleClass("col-sm-7");
    $(".section-media").toggleClass("col-sm-10");
    $("#timeline-bottom-container").toggleClass("col-sm-10");
    $("#timeline-bottom-container").toggleClass("col-sm-12");
    $("#timeline-related-reels").toggleClass("col-sm-10");
    $("#timeline-related-reels").toggleClass("col-sm-12");
  })

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
