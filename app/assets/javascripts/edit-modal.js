$(document).ready(function() {
  $('.media-edit').click(function() {
    $('.modal-edit-media').hide();
    $('#modal-edit-' + $(this).attr('data-medium')).show();

  });
});