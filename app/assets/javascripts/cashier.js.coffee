$ ->

  cache = {}

  suggestion = (res, data)->
    items = (item['name'] for item in data)
    res items

  $( '#order_salon_name' ).autocomplete
    minLength: 2
    source: ( req, res )->
      term = req.term
      if term in cache
        suggestion res, cache[ term ]
        return

      $.getJSON  "/salons.json", req, ( data, status, xhr )->
        cache[ term ] = data
        suggestion res, data

  $('#order_payment_type').on 'change', ->
    type = $(@).val()
    type = type.toLowerCase().replace(/::/, '-')
    $('.payment-type').hide()
    $(".payment-type.#{type}").show()

  $('#order_payment_type').trigger 'change'

