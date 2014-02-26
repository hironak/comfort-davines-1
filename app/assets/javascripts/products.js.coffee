jQuery ($)->

  $('.image-select a').on 'click', ->
    src = $(@).attr 'href'
    $('.main-image img').attr 'src', src
    $('.image-select a').removeClass 'active'
    $(@).addClass 'active'
    return false

  $('.ingredient img').tooltip(track: true)
