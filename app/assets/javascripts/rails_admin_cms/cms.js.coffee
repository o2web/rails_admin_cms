window.CMS ||= {}

CMS.with_scope = (body_class, callback) ->
  if $('body').hasClass(body_class)
    callback()

CMS.ready = (callback) ->
  $(document).on 'ready page:change', ->
    callback()

CMS.ready_with_scope = (body_class, callback) ->
  CMS.ready ->
    CMS.with_scope(body_class, callback)

#------------------------------------------------------------------------------#

CMS.ready ->
  CMS.flash_messages()
