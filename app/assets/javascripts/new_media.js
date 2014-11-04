$(document).ready(function() {
  if($("#upload-token-path").length) {
    var submit_button = $('#submit_pre_upload_form');
    var media_upload = $('#media_upload');
    //Get upload token from YouTube client
    submit_button.click(function () {
      var filepath = $("#file").val();
      var extension = getFileExtension(filepath);
      //If no file extension on the file, cry for help.
      if (extension == "") {
        return alert("Please add an extension to your filename and upload again.");
      }
      //If this is a movie file supported by YouTube, post to YouTube
      if (extension.match(/^(MOV|MPEG4|MP4|AVI|WMV|MPEGPS|FLV|3GPP|WEBM)$/i)) {
        upload_video(media_upload, submit_button);
      }
      // All other file types upload through paperclip
      else {
        upload_image(media_upload);
      }
    });

    var upload_video = function(media_upload, submit_button) {
      var upload_token_path = $("#upload-token-path").data("upload-token-path");
      $.ajax({
          type: 'POST',
          url: upload_token_path,
          data: $('#media_pre_upload').serialize(),
          dataType: 'json',
          success: function(response) {
            //With YouTube upload token and video_uid_url, upload video to YouTube
            media_upload.find('#token').val(response.token);
            media_upload.attr('action', response.url.replace(/^http:/i, window.location.protocol)).submit();
            submit_button.unbind('click').hide();
            $('.preloader').css('display', 'block');
          },
          error: function (xhr, ajaxOptions, thrownError) {
            //This is a common cause for YouTube upload errors:
            alert("Something went wrong. Please visit www.youtube.com and create a channel if you do not already have one.");
          }
      });
    }
    
    var upload_image = function(media_upload) {
      var image_upload_url = $('#image-upload-url').data("image-upload-url"); 
      combine_upload_forms();
      media_upload.attr('action', image_upload_url).submit();
    }

    //Add hidden copies of the pre_media_form fields to the media_upload form. NOTE: these fields are separated in a separate form
    //originalaly in order to create the YouTube upload token in the case of a video upload. See above.
    var combine_upload_forms = function() {
      var pre_media_form_groups = $("#media_pre_upload").children(".form-group").clone();
      pre_media_form_groups.children().removeAttr('required');
      pre_media_form_groups.hide();
      $("#upload_fields").prepend(pre_media_form_groups);
      $("#upload_fields #description").val($("#description").val()); //The description val, mysteriously, isn't copied.
      $("#upload_fields #media_reel_id").val($("#media_reel_id").val())
    }

    var getFileExtension = function(filename) {
      var a = filename.split(".");
      if( a.length === 1 || ( a[0] === "" && a.length === 2 ) ) {
          return "";
      }
      return a.pop();
    }
  }
});