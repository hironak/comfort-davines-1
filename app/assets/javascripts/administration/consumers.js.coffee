jQuery ($)->

  $('#consumer_search').hide()

  $('a[href="#consumer_search"]').on 'click', ->
    $('#consumer_search').slideToggle()
    false
