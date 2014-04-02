#= require jquery
#= require jquery.ui.all
#= require jquery_ujs
#= require_self
#= require_directory .
#= require ../scrolltop

jQuery ($)->
  $('.flexslider').flexslider
    animation: 'slide'
    directionNav: false

  $('.products a').on "click", ->
    id = $(@).data()['show']
    $('.products a').removeClass 'active'
    $(@).addClass 'active'
    $('.products-items').hide()
    $(".products-items##{id}").show()
    false

  $('.products-items h4').on 'click', ->
    $(@).next().slideToggle()

  $('.image-select a').on 'click', ->
    src = $(@).attr 'href'
    $('.main-image img').attr 'src', src
    $('.image-select a').removeClass 'active'
    $(@).addClass 'active'
    return false

  $('.accordion')
    .each ->
      $(@).nextUntil('.accordion').wrapAll('<div class="accordion-content" />')
    .on 'click', ->
      $(@).next('.accordion-content').slideToggle()

  $('.accordion-content').append $('.scrolltotop').clone().addClass('right')


  sample_checks = $('input[name="order[sample_ids][]"]')
  sample_checks.on 'change', ->
    if sample_checks.filter(':checked').length > 1
      sample_checks.filter(':not(:checked)').prop disabled: true
    else
      sample_checks.prop disabled: false


jQuery ($)->
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


