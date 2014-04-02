jQuery ($) ->
  $('.scrolltotop').on 'click', ->
    $(@).blur()
    bodyelem =
      if navigator.userAgent.match /Safari/
        $("body")
      else
        $("html,body")

    bodyelem.animate({'scrollTop':0})
    return false
