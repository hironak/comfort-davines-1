jQuery ($)->

  $('.image-select a').on 'click', ->
    src = $(@).attr 'href'
    $('.main-image img').attr 'src', src
    return false
