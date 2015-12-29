#= require jquery.form-validator

$(document).on 'ready page:change', ->
  return unless $('body').hasClass('cms-forms')

  $.validate(validateOnBlur: false)
