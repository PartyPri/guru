$(document).ready(function() {
  $('.media-share').click(function() {
    var share_media_id = $(this).attr("data-share-id");
    var share_reel_id = $(this).attr("data-reel-id");
    console.log(share_media_id === undefined);
    if(share_media_id === undefined){
      $('.modal-twitter-share').attr("href", "https://twitter.com/intent/tweet?url=http%3A%2F%2Fwww.evrystep.com%2Freels%2F"+share_reel_id);
      $('.modal-facebook-share').attr("href", "http://www.facebook.com/sharer/sharer.php?u=http://evrystep.com/reels/"+share_reel_id);
    }else{
      $('.modal-twitter-share').attr("href", "https://twitter.com/intent/tweet?url=http%3A%2F%2Fwww.evrystep.com%2Freels%2F"+share_reel_id+"%3Fmedia%3D"+share_media_id);
      $('.modal-facebook-share').attr("href", "http://www.facebook.com/sharer/sharer.php?u=http://evrystep.com/reels/"+share_reel_id+"?media="+share_media_id);
    }

  });
});
