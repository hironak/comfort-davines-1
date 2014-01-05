# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  editor = ace.edit('editor')
  style = $('.style textarea')
  body  = $('.body textarea')

  editor.setTheme "ace/theme/tomorrow"

  editor.setValue body.val()
  current = body

  editor.getSession().on 'change', ->
    current.val editor.getValue()

  body_mode = $('#page_render_type').val()
  editor.getSession().setMode "ace/mode/#{body_mode}"
  $('#page_render_type').on 'change', ->
    body_mode = $(@).val()
    editor.getSession().setMode "ace/mode/#{body_mode}" if current == body

  $('.selector a').on 'click', ->
    switch $(@).attr('href')
      when '.style'
        current = style
        editor.setValue style.val()
        editor.getSession().setMode "ace/mode/css"
      when '.body'
        current = body
        editor.setValue body.val()
        editor.getSession().setMode "ace/mode/#{body_mode}"
    false
