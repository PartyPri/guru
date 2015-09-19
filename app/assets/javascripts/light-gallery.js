$(document).ready(function() {
  var url_params = getUrlParameter('media');
  var share_media = $("li[data-share-id='"+url_params+"']");
  var share_url = share_media.attr("data-src")

  var gallery = startLightGallery(url_params, share_url);

  $('.media-edit').click(function() {
    gallery.destroy();
  });

  $('.media-share').click(function() {
    gallery.destroy();
  });

  $('.new-grid-item').click(function() {
    gallery.destroy();
  });
});

function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++) 
    {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam) 
        {
            return sParameterName[1];
        }
    }
} 

function startLightGallery(media_id, url) {
  if (typeof media_id != 'undefined' && media_id != "") {
    var gal = $('#lightgallery').lightGallery({
      dynamic: true,
      dynamicEl:[
        {"src" : url}
      ]
    });  
  }
  else {
    var gal = $('#lightgallery').lightGallery();
  }
  return gal;
}