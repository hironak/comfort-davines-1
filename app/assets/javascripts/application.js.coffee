#= require jquery
#= require jquery.ui.all
#= require jquery_ujs
#= require jquery.jscrollpane
#= require jquery.colorbox
#= require_self
#= require_directory .

$ ->

  $('input').on 'keypress', (e)->
    if e.which == 13
      e.preventDefault()

  $('.consumer .logout').on 'mouseover', ->
    $(@).find('.login').hide()
    $(@).find('.logout').show()

  $('.consumer .logout').on 'mouseout', ->
    $(@).find('.login').show()
    $(@).find('.logout').hide()

  $('.autosend').on 'change', ->
    $(@).submit()

  $('.side .category h4, .side .solution h4').on 'click', ->
    arrow = $(@).find('.arrow img')
    if @['opened'] == true
      arrow.css transform: 'rotate(0deg)'
    else
      arrow.css transform: 'rotate(90deg)'
    @['opened'] = !@['opened']
    $(@).next().slideToggle()

  $('.popup').colorbox()

jQuery ($)->

  $('.scroll').jScrollPane()

  $('.voice:eq(1) ~ .voice').hide()
  $('.voice_hide').hide()

  $('.voice_show a').on 'click', ->
    $('.voice').fadeIn()
    $('.voice_show').hide()
    $('.voice_hide').show()
    return false

  $('.voice_hide a').on 'click', ->
    $('.voice:eq(1) ~ .voice').fadeOut()
    $('.voice_show').show()
    $('.voice_hide').hide()
    return false
