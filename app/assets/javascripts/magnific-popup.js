$(document).ready(function() {
  $('.magnific').magnificPopup({
    type:'image',

    zoom: {
      enabled: true,
      duration: 300
    }

  });

    $('.magnific-video').magnificPopup({
    type:'iframe',

  });
});