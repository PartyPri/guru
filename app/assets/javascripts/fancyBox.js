$(document).ready(function() {
  $(".fancybox").fancybox({
    'nextEffect' : 'fade',
    'prevEffect' : 'fade',
    'maxWidth' : '1000px',
    'width' : 700,
    'height' : 900,
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
});