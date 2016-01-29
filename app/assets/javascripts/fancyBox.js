$(document).ready(function() {
  //Fancybox Settings and Configuration
  $(".fancybox").fancybox({
    'nextEffect' : 'fade',
    'prevEffect' : 'fade',
    'maxWidth' : '1000px',
    'width' : 700,
    'minHeight' : 900,
    'autoDimensions' : false,
    'autoSize' : false,
    helpers : {
      overlay : {
          css : {
              'background' : 'rgba(0, 0, 0, 0.75)'
          }
      }
    }
  });

  //Trigger Fancybox with url parameter: ?media= 
  var url_params = getUrlParameter('media');
  var share_media = $("li[data-share-id='"+url_params+"']");
  var share_url = share_media.attr("data-src")

  $('#media-share-'+url_params).fancybox({
    'nextEffect' : 'fade',
    'prevEffect' : 'fade',
    'maxWidth' : '1000px',
    'width' : 700,
    'minHeight' : 900,
    'autoDimensions' : false,
    'autoSize' : false,
    helpers : {
      overlay : {
          css : {
              'background' : 'rgba(0, 0, 0, 0.75)'
          }
      }
    }
  }).trigger('click');

  //Close Fancybox when other modals open
  $('.close-fancybox').click(function() {
    $.fancybox.close();
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