#= require jquery
#= require jquery.ui.all
#= require jquery_ujs
#= require_self
#= require_directory .

jQuery ($)->
  $('.flexslider').flexslider
    animation: 'slide'
    directionNav: false

  $('.products a').on "click", ->
    id = $(@).data()['show']
    $('.products a').removeClass 'active'
    $(@).addClass 'active'
    $('.products-items').hide()
    $(".products-items##{id}").show()
    false

  $('.products-items h4').on 'click', ->
    $(@).next().slideToggle()
