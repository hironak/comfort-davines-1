$ ->

  $('.scrolltotop').on 'click', ->
    $(@).blur()
    $('html, body').animate({'scrollTop':0})
    return false
