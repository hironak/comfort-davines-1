#= require jquery
#= require jquery.ui.all
#= require jquery_ujs
#= require_self
#= require_directory .

$ ->
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
