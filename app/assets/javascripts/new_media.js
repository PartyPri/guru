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

  var validate_and_upload = function(media_upload, submit_button) {
    if(($("#description").val() != "") && ($("#media_reel_id").val() != "")) {
      upload_video(media_upload, submit_button);
    }
    else {
      alert("Please fill out all form fields");
    }
  }

  var upload_video = function(media_upload, submit_button) { 
    media_upload.submit();
  }

  var upload_image = function(media_upload) {
    var image_upload_url = $('#image-upload-url').data("image-upload-url");
    media_upload.attr('action', image_upload_url).submit();
  }

  //Add hidden copies of the pre_media_form fields to the media_upload form. NOTE: these fields are separated in a separate form
  //originalaly in order to create the YouTube upload token in the case of a video upload. See above.
  // var combine_upload_forms = function() {
  //   var pre_media_form_groups = $("#media_pre_upload").children(".form-group").clone();
  //   pre_media_form_groups.children().removeAttr('required');
  //   pre_media_form_groups.hide();
  //   $("#upload_fields").prepend(pre_media_form_groups);
  //   $("#upload_fields #description").val($("#description").val()); //The description val, mysteriously, isn't copied.
  //   $("#upload_fields #media_reel_id").val($("#media_reel_id").val())
  // }

  var getFileExtension = function(filename) {
    var a = filename.split(".");
    if( a.length === 1 || ( a[0] === "" && a.length === 2 ) ) {
        return "";
    }
    return a.pop();
  }
});