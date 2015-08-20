jQuery ->
  $(".comment-form")
    .on "ajax:beforeSend", (evt, xhr, settings) ->
      $(this).find('textarea')
        .addClass('uneditable-input')
        .attr('disabled', 'disabled');
    .on "ajax:success", (evt, data, status, xhr) ->
      $(this).find('textarea')
        .removeClass('uneditable-input')
        .removeAttr('disabled', 'disabled')
        .val('');
      $(data.comments).hide().insertAfter($(this)).show('fast')

  $(document)
    .on "ajax:beforeSend", "#delete_comment", ->
      $(this.parentElement).fadeTo('fast', 0.5)
    .on "ajax:success", "#delete_comment", ->
      $(this.parentElement).hide('fast')
    .on "ajax:error", "#delete_comment", ->
      $(this.parentElement).fadeTo('fast', 1)
