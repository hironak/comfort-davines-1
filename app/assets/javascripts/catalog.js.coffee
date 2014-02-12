jQuery ($)->

  $('.category-select').on 'click', ->
    klass = $(@).data 'select'
    $('.series-items .item').hide()
    $(".series-items .item.#{klass}").show()
    return false
