$(document).ready(function() {
  $('#tag-select').change(function() {
    tag = $(this).val();
    var data = {'tag':tag};

    $.ajax({
      type: 'GET',
      url: '/reels',
      data: data,
      dataType: 'json',
      success: function(response) {
        var values = getReelInfo(response);
        console.log(values);

      }
    });
  });

  function getReelInfo(reel) {
    var names =[];
    var reel_list = reel;

    for (i = 0; i < reel_list.length; i++) {
      var name = reel_list[i].name;
      names.push(name);
    }

    return names;
  };
});