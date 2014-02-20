$ ->

  cache = {}

  suggestion = (res, data)->
    items = (item['name'] for item in data)
    res items

  $( '#order_salon_name' ).autocomplete
    minLength: 1
    source: ( req, res )->
      term = req.term
      prefecture = $('#order_salon_prefecture').val()
      req.prefecture = prefecture
      cache_key = "#{term}-#{prefecture}"
      if cache_key in cache
        suggestion res, cache[ cache_key ]
        return

      $.getJSON  "/salons.json", req, ( data, status, xhr )->
        cache[ cache_key ] = data
        suggestion res, data

  $('#order_payment_type').on 'change', ->
    type = $(@).val()
    type = type.toLowerCase().replace(/::/, '-')
    $('.payment-type').hide()
    $(".payment-type.#{type}").show()

  $('#order_payment_type').trigger 'change'

