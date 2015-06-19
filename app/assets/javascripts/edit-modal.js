$(document).ready(function() {
  $('.media-edit').click(function() {
    $('.modal-edit-media').hide();
    $('#modal-edit-' + $(this).attr('data-medium')).show();

    $('.btn-cancel').click(function() {
      $('#edit-modal').modal('hide');
    });
  });

  $('#edit-modal').on('hide.bs.modal', function(e) {
    $('form.edit_reel').trigger("reset");
  });
});