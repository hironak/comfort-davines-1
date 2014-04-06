#= require jquery
#= require jquery.ui.all
#= require jquery_ujs
#= require jquery.colorbox
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

  $('.accordion-content:not(:last)').append $('.scrolltotop').clone().addClass('right')


  sample_checks = $('input[name="order[sample_ids][]"]')
  sample_checks.on 'change', ->
    if sample_checks.filter(':checked').length > 1
      sample_checks.filter(':not(:checked)').prop disabled: true
    else
      sample_checks.prop disabled: false

  $('#buy').colorbox
    opacity: 0.3
    closeButton: false
    scrolling: false
    width: "80%"
    height: "80%"
    html: ->
      $('#buy-html').html()

jQuery ($)->
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

  $('#order_payment_type').on 'change', ->
    type = $(@).val()
    type = type.toLowerCase().replace(/::/, '-')
    $('.payment-type').hide()
    $(".payment-type.#{type}").show()

  $('#order_payment_type').trigger 'change'


