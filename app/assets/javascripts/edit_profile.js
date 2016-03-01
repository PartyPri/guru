function setSelectionToCanvas(c) {
  var canvas = $('#cropped_image_canvas')[0];
  canvas.width = c.w;
  canvas.height = c.h;
  var ctx = canvas.getContext("2d");
  var image = $('#profile_image_viewer')[0];

  ctx.clearRect ( 0 , 0 , canvas.width, canvas.height );
  ctx.drawImage(image, c.x, c.y, c.w, c.h, 0, 0, c.w, c.h);
  profileAvatarUpdated = true;
}

function readURL(input, viewer) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function(e) {
      $(viewer).attr('src', e.target.result);
      $(viewer).Jcrop({
        keySupport: false,
        aspectRatio: 1,
        boxWidth: $(".edit_user").width() - 5,
        onSelect: setSelectionToCanvas
      });
    };

    reader.readAsDataURL(input.files[0]);
  }
}

function dataURItoBlob(dataURI) {
  // convert base64/URLEncoded data component to raw binary data held in a string
  var byteString;
  if (dataURI.split(',')[0].indexOf('base64') >= 0)
      byteString = atob(dataURI.split(',')[1]);
  else
      byteString = unescape(dataURI.split(',')[1]);

  // separate out the mime component
  var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];

  // write the bytes of the string to a typed array
  var ia = new Uint8Array(byteString.length);
  for (var i = 0; i < byteString.length; i++) {
      ia[i] = byteString.charCodeAt(i);
  }

  return new Blob([ia], {type:mimeString});
}

function cloneFormDataAndAddCroppedImage(form) {
  var formData = new FormData(form);

  if (profileAvatarUpdated) {
    var canvas = $('#cropped_image_canvas')[0];
    var dataURL = canvas.toDataURL();
    var blob = dataURItoBlob(dataURL);

    formData.append("user[cropped_image]", blob);
  }
  return formData;
}

$(function() {
  window.profileAvatarUpdated = false;

  $("#user_avatar").change(function(){
    readURL(this, '#profile_image_viewer');
    $('#cropped_image_canvas').removeClass('hidden');
    var imagePath = $('#user_avatar').val().split("\\");
    imagePath = imagePath[imagePath.length - 1]
    $('#avatar-image-path').html(imagePath);
  });
  $('img#profile_image_viewer[src=""]').hide();

  $("#user_cover_photo").change(function(){
    readURL(this, '#cover_image_viewer');
    var imagePath = $('#user_cover_photo').val().split("\\");
    imagePath = imagePath[imagePath.length - 1]
    $('#cover-image-path').html(imagePath);
  });
  $('img#cover_image_viewer[src=""]').hide();

  if (typeof evryStepUserId != 'undefined')  {
    var formSelectorString = "form#edit_user_" + evryStepUserId;
    $(formSelectorString).submit(function(event) {
      var formData = cloneFormDataAndAddCroppedImage($(formSelectorString)[0]);

      $('.preloader').show();
      
      $.ajax({
        url: "/users/" + evryStepUserId,
        data: formData,
        processData: false,
        contentType: false,
        type: 'POST',
        success: function(data){
          window.location.href = "/users/" + evryStepUserId;
        }
      });

      event.preventDefault();
    });
  }
});
