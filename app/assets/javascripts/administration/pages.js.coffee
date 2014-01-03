# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.selector a').on 'click', ->
    switch $(@).attr('href')
      when '.style'
        $('.style').show()
        $('.body').hide()
      when '.body'
        $('.style').hide()
        $('.body').show()
    false
