$(document).ready(function() {
  $('.tag-select').click(function() {
    //Highlights active tag background-color
    $(this).parent().find('.tag-select').css('background-color', '#9CB4EF');
    $(this).css('background-color', '#5a82e4');

    //Get value of clicked tag
    var tag = $(this).text().trim();

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

        //sort response in descending order to show newest reels first
        var sorted_response = response.sort(function(a, b){
          if (a.updated_at > b.updated_at) { return -1; }
          if (a.updated_at < b.updated_at) { return 1; }
          return 0;
        })

        //For each object in AJAX response with more than 2 media objects
        //Get info for that reel through getReelInfo
        //Append HTML from getReelInfo to page
        for (i = 0; i < sorted_response.length; i++) {
          var media_count = sorted_response[i].images.length + sorted_response[i].videos.length;

          if (media_count > 2) {
            var reels = getReelInfo(sorted_response, i);
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
    var description = reel.description;
    var id = reel.id;
    var media_count = reel.images.length + reel.videos.length;
    var img_html = " ";
    var vid_html = " ";
    var media_limit = 0;
    var updated_datetime = $.timeago(reel.updated_at);
    var author = reel.user.first_name + " " + reel.user.last_name;
    var view_count = reel.impressions.length;

    //truncate name and description if too long
    if(name.length > 32){
      name = name.substring(0,32) + "...";
    }
    if(description.length > 97){
      description = description.substring(0, 97) + "...";
    }

    //Loop through getReelImages and append to img_html
    for (r = reel.images.length-1; r >= 0; r--) {

      //Prevent more than 1 items in teaser
      if (media_limit == 1) {
        break;
      }

      var images = getReelImages(reel, r);
      img_html += images;
      media_limit += 1;
    }

    //Loop thorugh getReelVideos and append to vid_html
    for (v = reel.videos.length-1; v >= 0; v--) {
      //Prevent more than 4 items in teaser
      if (media_limit == 1) {
        break;
      }

      var vids = getReelVideos(reel, v);
      vid_html += vids;
      media_limit += 1;
    }

    //Build teaser div with reel information
    var html = "";
    if(reel.featured){
      html = "<div class='teaser'><a href='/reels/"+ id +"'><div class='featured-teaser-reel-tag'><span class='featured-tag'>Featured!</span></div><ul class='media-list'>" + img_html + vid_html + "</ul><br /><div class='reel-teaser-info'><h3 class='name'>" + name + "</h3><h5>"+author+" | "+ updated_datetime +"</h5><p>" + description + "</p><br /><h5><i class='fa fa-eye'></i>&nbsp;" + view_count + "</h5></div><hr></hr></a></div>"
    }else{
      html = "<div class='teaser'><a href='/reels/"+ id +"'><ul class='media-list'>" + img_html + vid_html + "</ul><br /><div class='reel-teaser-info'><h3 class='name'>" + name + "</h3><h5>"+author+" | "+updated_datetime+"</h5><p>" + description + "</p><br /><h5><i class='fa fa-eye'></i>&nbsp;" + view_count + "</h5></div><hr></hr></a></div>"
    }

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
