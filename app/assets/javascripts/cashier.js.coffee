# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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

