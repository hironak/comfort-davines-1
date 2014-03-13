jQuery ($)->

  width = -> $('body').width()

  slides = $('.slide')

  point_on = $('.points .on img').prop 'src'
  point_off = $('.points .off img').prop 'src'

  points = $('.points').empty()
  slides.each -> points.append $('<li><img /></li>')
  points = $('.points img')

  point_move = (current)->
    slides.each (i)->
      $(points.get(i)).prop src: (if current == i then point_on else point_off)

  current = 0

  point_move current

  rotate = ->
    current++
    current = 0 if slides.length <= current
    point_move current
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
