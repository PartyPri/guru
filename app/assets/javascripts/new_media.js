$(document).ready(function() {
  var submit_button = $('#submit-media');
  var media_upload = $('#media_upload');

  $("#video_description").bind('input propertychange', function () {
    $("#caption-counter").html(function() {
       return $("#video_description").val().split(" ").length + "/10";
    });
    if ($("#video_description").val().split(" ").length > 10) {
      $("#video_description").css("color", "red");
      $("#caption-limit-warning").removeClass("hidden");
    }else{
      $("#video_description").css("color", "#404040");
      $("#caption-limit-warning").addClass("hidden");
    }
  });

  submit_button.click(function (event) {
    event.preventDefault();
    var filepath = $("#video_file").val();
    var extension = getFileExtension(filepath);
    //If no file extension on the file, cry for help.
    if (extension === "") {
      return alert("Please add an extension to your filename and upload again.");
    }
    //If this is a movie file supported by YouTube, post to YouTube
    if (extension.match(/^(MOV|MPEG4|MP4|AVI|WMV|MPEGPS|FLV|3GPP|WEBM)$/i)) {
      validate_and_upload(media_upload, submit_button);
    }
    // All other file types upload through paperclip
    else {
      upload_image(media_upload);
    }
  });

  var upload_video = function(media_upload, submit_button) {
    $('.preloader').show();
    media_upload.submit();
  };

  var upload_image = function(media_upload) {
    var image_upload_url = $('#image-upload-url').data("image-upload-url");

    if(($("#video_description").val() !== "") && ($("#video_reel_id").val() !== "" && $("#video_description").val().split(" ").length < 11)) {
      $('.preloader').show();
      media_upload.attr('action', image_upload_url).submit();
    }

    else {
      alert("Please fill out all form fields. Or your caption is too long.");
    }
  };

  var getFileExtension = function(filename) {
    var a = filename.split(".");
    if( a.length === 1 || ( a[0] === "" && a.length === 2 ) ) {
        return "";
    }
    return a.pop();
  };

  var validate_and_upload = function(media_upload, submit_button) {

    if(($("#video_description").val() !== "") && ($("#video_reel_id").val() !== "") && $("#video_description").val().split(" ").length < 11) {
      $('.preloader').show();
      upload_video(media_upload, submit_button);
    }
    else {
      alert("Please fill out all form fields. Or your caption is too long.");
    }
  };

  //changing finished link based on reel selected
  $("#video_reel_id").change(function(){
    var reelNum = $("#video_reel_id").val();
    console.log(reelNum);
    $("#image-new-finish").attr("href", "../reels/" + reelNum);
  });

  $("#media_upload").dropzone({
    paramName: "video[file]",
    url: "../images",
    method: "post",
    addRemoveLinks: true,
    success: function(file, response){
			// find the remove button link of the uploaded file and give it an id
			// based of the fileID response from the server
			$(file.previewTemplate).find('.dz-remove').attr('id', response.fileID);
			// add the dz-success class (the green tick sign)
			$(file.previewElement).addClass("dz-success");
		},
    //when the remove button is clicked
    removedfile: function(file){
      // grap the id of the uploaded file we set earlier
      var id = $(file.previewTemplate).find('.dz-remove').attr('id');

      // make a DELETE ajax request to delete the file
      $.ajax({
        type: 'DELETE',
        url: '../images/' + id,
        success: function(data){
          console.log(data.message);
          $(file.previewTemplate).find('.dz-remove').parent().remove();
        }
      });
    }
  });
});
