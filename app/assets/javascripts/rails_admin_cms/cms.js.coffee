window.CMS ||= {}

# https://github.com/gemgento/rails_script/blob/master/lib/generators/rails_script/install/templates/base.js.coffee
CMS.clear_event_handlers = ->
  $(document).on 'page:before-change', ->
    for element in [window, document]
      for event, handlers of ($._data(element, 'events') || {})
        for handler in handlers
          if handler? && handler.namespace == ''
            $(element).off event, handler.handler

#------------------------------------------------------------------------------#

CMS.with_scope_any = (body_classes..., handler) ->
  for body_class in body_classes
    if CMS.with_scope(body_class, handler)
      return

CMS.with_scope_all = (body_classes..., handler) ->
  for body_class in body_classes
    if !$('body').hasClass(body_class)
      return
  handler()

CMS.with_scope_none = (body_classes..., handler) ->
  without_scope = true
  for body_class in body_classes
    if $('body').hasClass(body_class)
      without_scope = false
  if without_scope
    handler()

CMS.with_scope = (body_class, handler) ->
  if $('body').hasClass(body_class)
    handler()
    true
  else
    false

#------------------------------------------------------------------------------#

CMS.ready_with_scope_any = (body_classes..., handler) ->
  CMS.ready ->
    CMS.with_scope_any(body_classes..., handler)

CMS.ready_with_scope_all = (body_classes..., handler) ->
  CMS.ready ->
    CMS.with_scope_all(body_classes..., handler)

CMS.ready_with_scope_none = (body_classes..., handler) ->
  CMS.ready ->
    CMS.with_scope_none(body_classes..., handler)

CMS.ready_with_scope = (body_class, handler) ->
  CMS.ready ->
    CMS.with_scope(body_class, handler)

CMS.ready = (handler) ->
  $(document).on 'ready page:change', ->
    handler()

#------------------------------------------------------------------------------#

CMS.element_on = (name, events, handler) ->
  $(document).on(events, "[data-js-#{ name }]", handler)

CMS.element = (name) ->
  $("[data-js-#{ name }]")

$.fn.extend
  cms_data: (name) ->
    $(this).data("js-#{ name }")

#------------------------------------------------------------------------------#

CMS.ready ->
  CMS.clear_event_handlers()
  CMS.flash_messages()
