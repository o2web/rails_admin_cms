CMS.flash_messages = ->
  $('[data-cms-flash]').fadeIn().delay(3500).fadeOut(800);

$(document).on 'ready page:change', ->
  CMS.flash_messages()
