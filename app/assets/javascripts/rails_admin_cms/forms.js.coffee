#= require jquery.form-validator

CMS.ready_with_scope 'cms-forms', ->
  $.validate(validateOnBlur: false)
