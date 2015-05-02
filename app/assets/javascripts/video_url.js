$(document).ready(function() {

  function extractVideoID(url){
      var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
      var match = url.match(regExp);
      if ( match && match[7].length == 11 ){
          return match[7];
      }
  }

  $('#add-video').click(function() {
    url = extractVideoID($('#video-url').val());
    $('#uid').val(url);
  });
});