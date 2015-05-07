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

    for (r = 0; r < reel.images.length; r ++) {
      var images = reel.images[r]
      var img = "<li style='background-image: url("+images.photo+")' class='teaser-media'></li>"
    }

    //Build teaser div with reel information
    var html = "<div class='teaser'><a href='/reels/" + id + "'><h2>" + name + "</h2><ul class='list-inline'>" + img + "</ul><p>" + description + "</p></a></div>"

    return html

  };
});