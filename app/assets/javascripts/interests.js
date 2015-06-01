$(document).ready(function() {
  $('#tag-select').change(function() {
    //When dropdown changes, get it's value
    var tag = $(this).val();

    //Get Interest ID from URL
    var url = window.location.pathname;
    var interest_id = url.substring(url.lastIndexOf('/') + 1);

    //Using tag, create query parameter for GET request
    var data = {'tag':tag, 'interest_id':interest_id};

    $.ajax({
      type: 'GET',
      url: '/reels',
      data: data,
      dataType: 'json',
      success: function(response) {

        //Reset content of #reels div
        $(".content-container#reels").html("");

        //For each object in AJAX response with more than 2 media objects
        //Get info for that reel through getReelInfo
        //Append HTML from getReelInfo to page
        for (i = 0; i < response.length; i++) {
          var media_count = response[i].images.length + response[i].videos.length;

          if (media_count > 2) {
            var reels = getReelInfo(response, i);
            $(".content-container#reels").append(reels);
          }
        };
      }
    });
  });

  function getReelInfo(reel, num) {
    //Get information we need about reel
    var reel = reel[num]
    var name = reel.name;
    var description = reel.description
    var id = reel.id
    var media_count = reel.images.length + reel.videos.length;
    var img_html = " ";
    var vid_html = " ";
    var media_limit = 0;

    //Loop through getReelImages and append to img_html
    for (r = reel.images.length-1; r >= 0; r--) {

      //Prevent more than 4 items in teaser
      if (media_limit == 4) {
        break;
      }

      var images = getReelImages(reel, r);
      img_html += images;
      media_limit += 1;
    }

    //Loop thorugh getReelVideos and append to vid_html
    for (v = reel.videos.length-1; v >= 0; v--) {
      //Prevent more than 4 items in teaser
      if (media_limit == 4) {
        break;
      }

      var vids = getReelVideos(reel, v);
      vid_html += vids;
      media_limit += 1;
    }

    //Build teaser div with reel information
    var html = "<div class='teaser'><a href='/reels/" + id + "'><h2>" + name + "</h2><ul class='list-inline'>" + img_html + vid_html + "</ul><p>" + description + "</p></a></div>"

    return html
  };

  function getReelImages(reel, img_num) {
    var img_html_build = "<li style='background-image: url("+reel.images[img_num].photo+")' class='teaser-media'></li>"
    return img_html_build
  };

  function getReelVideos(reel, vid_num) {
    var vid_html_build = "<li style='background-image: url(http://img.youtube.com/vi/"+ reel.videos[vid_num].uid +"/0.jpg);' class='teaser-media'></li>"
    return vid_html_build
  };
});
