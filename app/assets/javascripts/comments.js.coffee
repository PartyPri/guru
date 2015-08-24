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
      $('.comment_submit').removeAttr('disabled').attr('value', 'Talk!')
      $(data.comments).hide().insertAfter($(this)).show('fast')

  $(document)
    .on "ajax:beforeSend", "#delete_comment", ->
      $(this.parentElement).fadeTo('fast', 0.5)
    .on "ajax:success", "#delete_comment", (evt, data, status, xhr) ->
      $(this.parentElement).hide('fast')
      $("#replies-#{data.id}").hide('fast')
    .on "ajax:error", "#delete_comment", ->
      $(this.parentElement).fadeTo('fast', 1)

    .on "ajax:beforeSend", ".reply-form", (evt, xhr, settings) ->
      $(this).find('textarea')
        .addClass('uneditable-input')
        .attr('disabled', 'disabled');
    .on "ajax:success", ".reply-form", (evt, data, status, xhr) ->
      $(data.division).show().append(data.comments).show('slow')
      $(this).hide('fast', -> $(this).remove())
