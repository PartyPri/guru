$(document).on 'ajax:success', 'a.vote', (status,data,xhr)->
  if data.count > 0
    $(".votes-count[data-id=#{data.id}]").css('display', 'inline')
  $(".votes-count[data-id=#{data.id}]").text data.count
  return