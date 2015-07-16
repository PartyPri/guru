$(document).ready(function() {
  var gallery = $('#lightgallery').lightGallery();

  $('.media-edit').click(function() {
    gallery.destroy();
  });

  $('.new-grid-item').click(function() {
    gallery.destroy();
  });
});