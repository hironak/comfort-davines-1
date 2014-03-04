jQuery ($)->

  width = -> $('body').width()

  slides = $('.slide')

  current = 0

  rotate = ->
    current++
    current = 0 if slides.length < current
    $('.background').animate 'scrollLeft' : width() * current

  resize = ->
    w = width()
    $('.background').scrollLeft 0 #w * current
    $('.background .frame').css 'width', w * slides.length
    slides.css 'width', w

  $(window).on 'resize', resize

  resize()

  $(window).on 'load', -> setInterval rotate, 3000

jQuery ($) ->

  products = $('.products .frame ul li')

  w = products.width()

  $('.products .frame ul').width w * products.length

  frame = $('.products .frame')

  scrollTo = (pos) -> frame.animate scrollLeft: pos

  prev = -> scrollTo "-=#{w}px"
  next = -> scrollTo "+=#{w}px"

  $('.products .prev').on 'click', prev
  $('.products .next').on 'click', next

  $(window).on 'load', -> setInterval next, 3000
