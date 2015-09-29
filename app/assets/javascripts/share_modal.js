$(document).ready(function() {
  $('.media-share').click(function() {
    var share_media_id = $(this).attr("data-share-id");
    var share_reel_id = $(this).attr("data-reel-id");

    $('.modal-share-button').attr("href", "https://twitter.com/intent/tweet?url=http%3A%2F%2Fwww.evrystep.com%2Freels%2F"+share_reel_id+"%3Fmedia%3D"+share_media_id)

  });
});