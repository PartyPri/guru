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

    $('#share_button').click(function(e){
      e.preventDefault();
        FB.ui(
        {
          method: 'share_open_graph',
          action_type: 'og.likes',
          action_properties: JSON.stringify({
              object: share_object,
          })
        }, function(response){
            if (response && !response.error_code) {
            alert('Posting completed.');
          } else {
            //Flash error unless post failed because user canceled the post manually
            if (response.error_code != 4201) {
              alert('Error while posting.');
            }
          }
      });
    });
 }
});