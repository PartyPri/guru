$(document).ready(function() {
  $('#tag-select').change(function() {
    //When dropdown changes, get it's value
    var tag = $(this).val();

    //Using tag, create query parameter for GET request
    var data = {'tag':tag};

    $.ajax({
      type: 'GET',
      url: '/reels',
      data: data,
      dataType: 'json',
      success: function(response) {
        console.log(response)

        //Reset content of #reels div
        $(".content-container#reels").html("");

        //For each object in AJAX response, call getReelInfo function
        //Append HTML from getReelInfo function to page
        for (i = 0; i < response.length; i++) {
          var reels = getReelInfo(response, i);
          $(".content-container#reels").append(reels);
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
    var img_html = " ";
    var vid_html = " ";

    for (r = 0; r < reel.images.length; r++) {
      var images = getReelImages(reel, r);
      img_html += images;
    }

    for (v = 0; v < reel.videos.length; v++) {
      var vids = getReelVideos(reel, v);
      vid_html += vids;
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