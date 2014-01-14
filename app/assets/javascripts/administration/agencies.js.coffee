$ ->

  cache = {}

  suggestion = (res, data)->
    items = (label: item['name'], value: item['id'] for item in data)
    res items

  $( '#salon_select' ).autocomplete
    minLength: 2
    source: ( req, res )->
      term = req.term
      if term in cache
        suggestion res, cache[ term ]
        return

      $.getJSON  "/salons.json", req, ( data, status, xhr )->
        cache[ term ] = data
        suggestion res, data

    select: (evt, ui)->
      $('<li />').append(
        $('<input type="hidden" name="agency[salon_ids][]" />').val(ui.item.value),
        $('<span />').text ui.item.label
      ).appendTo('.salons')
