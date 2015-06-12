$(document).ready(function() {
  var submit_button = $('#submit-media')
  var media_upload = $('#media_upload');

  submit_button.click(function (event) {
    event.preventDefault();
    var filepath = $("#video_file").val();
    var extension = getFileExtension(filepath);
    //If no file extension on the file, cry for help.
    if (extension == "") {
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
  }

  var upload_image = function(media_upload) {
    var image_upload_url = $('#image-upload-url').data("image-upload-url");

    if(($("#video_description").val() != "") && ($("#video_reel_id").val() != "")) {
      media_upload.attr('action', image_upload_url).submit();
    }

    else {
      alert("Please fill out all form fields");
    }    
  }

  var getFileExtension = function(filename) {
    var a = filename.split(".");
    if( a.length === 1 || ( a[0] === "" && a.length === 2 ) ) {
        return "";
    }
    return a.pop();
  }

  var validate_and_upload = function(media_upload, submit_button) {
    if(($("#video_description").val() != "") && ($("#video_reel_id").val() != "")) {
      upload_video(media_upload, submit_button);
    }
    else {
      alert("Please fill out all form fields");
    }
  }
});