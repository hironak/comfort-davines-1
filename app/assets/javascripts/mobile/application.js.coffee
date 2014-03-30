#= require jquery
#= require jquery.ui.all
#= require jquery_ujs
#= require_self
#= require_directory .

jQuery ($)->
  $('.flexslider').flexslider
    animation: 'slide'
    directionNav: false

  $('.lineup a').on "click", ->
    id = $(@).data()['show']
    $('.lineup a').removeClass 'active'
    $(@).addClass 'active'
    $('.lineup-items').hide()
    $(".lineup-items##{id}").show()
    false

  $('.lineup-items h4').on 'click', ->
    $(@).next().slideToggle()
