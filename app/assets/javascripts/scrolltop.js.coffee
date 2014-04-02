jQuery ($) ->
  $('.scrolltotop').on 'click', ->
    $(@).blur()
    $("body").animate({'scrollTop':0})
    return false
