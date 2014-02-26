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
    $('.frame').css 'width', w * slides.length
    slides.css 'width', w

  $(window).on 'resize', resize

  resize()

  rotate()

  # setInterval rotate, 3000
