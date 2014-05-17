# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  
  $('#media1a').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $("#media1c").html($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $("#media1b").on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $("#media1c").html($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('#media2a').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $("#media2c").html($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $("#media2b").on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $("#media2c").html($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('#media3a').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $("#media3c").html($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $("#media3b").on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $("#media3c").html($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('#media4a').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $("#media4c").html($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $("#media4b").on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $("#media4c").html($(this).data('fields').replace(regexp, time))
    event.preventDefault()


#jQuery ->
  #$('form').on 'click', '.add_fields', (event) ->
   # time = new Date().getTime()
    #regexp = new RegExp($(this).data('id'), 'g')
    #$(this).after($(this).data('fields').replace(regexp, time))
    #$("#added-media").append($(this).data('fields').replace(regexp, time))
    #$("#media1b").replaceWith($(this).data('fields').replace(regexp, time))
    #event.preventDefault()