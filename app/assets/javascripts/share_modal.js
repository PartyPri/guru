$(document).ready(function() {
  $('.media-share').click(function() {
    var share_media_id = $(this).attr("data-share-id");
    var share_reel_id = $(this).attr("data-reel-id");
    var share_url = $(this).attr("data-share-url");
    var media_img = $(this).attr("data-share-img");
    var share_title = $(this).attr("data-share-title");
    console.log(media_img);

    $('#share-title').html(share_title);

    if(media_img === '/photos/original/missing.png' || media_img === undefined){
      $('#modal-share-image').hide();
    }else{
      $('#modal-share-image').attr("src", media_img).show();
    }

    if(share_url === undefined){
      $('#share-url').val("http://evrystep.com/reels/"+share_reel_id);
    }else{
      $('#share-url').val(share_url);
    }

    if(share_media_id === undefined){
      $('.modal-twitter-share').attr("href", "https://twitter.com/intent/tweet?url=http%3A%2F%2Fwww.evrystep.com%2Freels%2F"+share_reel_id);
      $('.modal-facebook-share').attr("href", "http://www.facebook.com/sharer/sharer.php?u=http://evrystep.com/reels/"+share_reel_id);
    }else{
      // $('.modal-twitter-share').attr("href", "https://twitter.com/intent/tweet?url=http%3A%2F%2Fwww.evrystep.com%2Freels%2F"+share_reel_id+"%3Fmedia%3D"+share_media_id);
      // $('.modal-facebook-share').attr("href", "http://www.facebook.com/sharer/sharer.php?u=http://evrystep.com/reels/"+share_reel_id+"?media="+share_media_id);
      $('.modal-twitter-share').attr("href", "https://twitter.com/intent/tweet?url=http%3A%2F%2Fwww.evrystep.com%2Freels%2F"+share_reel_id+share_media_id);
      $('.modal-facebook-share').attr("href", "http://www.facebook.com/sharer/sharer.php?u=http://evrystep.com/reels/"+share_reel_id+share_media_id);
    }

  });
});
