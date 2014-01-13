# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  cache = {}

  $( '#order_salon_name' ).autocomplete
    minLength: 2
    source: ( req, res )->
      term = req.term
      if term in cache
        res( cache[ term ] )
        return

      $.getJSON  "/salons.json", req, ( data, status, xhr )->
        cache[ term ] = data
        res( data )
