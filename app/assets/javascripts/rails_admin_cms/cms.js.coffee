$.fn.extend
  data_js: (name = null) ->
    if name?
      $(this).data("js-#{ name }")
    else
      for key, value of $(this).data()
        if key.match /^js/
          return value

class CMS
  @start: =>
    @ready =>
      @clear_event_handlers()
      @flash_messages()
      @validate_mailchimp()

    @ready_with_scope 'cms-forms', =>
      @validate()

    @ready_with_scope 'cms-edit-mode', =>
      @data_js('cms-sortable').each ->
        $(this).sortable
          update: (event, ui) ->
            url = $(this).data_js()['url']

            target = $(ui.item)
            id = target.data_js('cms-sortable-id')
            unique_key = { position: target.index() + 1 }
            payload = $.param(id: id, unique_key: unique_key)

            $.post(url, payload)


  # https://github.com/gemgento/rails_script/blob/master/lib/generators/rails_script/install/templates/base.js.coffee
  @clear_event_handlers: =>
    $(document).on 'page:before-change', ->
      for element in [window, document]
        for event, handlers of ($._data(element, 'events') || {})
          for handler in handlers
            if handler? && handler.namespace == ''
              $(element).off event, handler.handler

  @flash_messages: =>
    @data_js('cms-flash').fadeIn().delay(3500).fadeOut(800)

  @validate: =>
    $.validate({ modules: 'security, file', validateOnBlur: false})

  @validate_mailchimp: =>
    $.validate(form: '#mailchimp_form', validateOnBlur: false)

  @with_scope_any: (body_classes..., handler) =>
    for body_class in body_classes
      if @with_scope(body_class, handler)
        return

  @with_scope_all: (body_classes..., handler) =>
    for body_class in body_classes
      if !$('body').hasClass(body_class)
        return
    handler()

  @with_scope_none: (body_classes..., handler) =>
    without_scope = true
    for body_class in body_classes
      if $('body').hasClass(body_class)
        without_scope = false
    if without_scope
      handler()

  @with_scope: (body_class, handler) =>
    if $('body').hasClass(body_class)
      handler()
      true
    else
      false

  @ready_with_scope_any: (body_classes..., handler) =>
    @ready =>
      @with_scope_any(body_classes..., handler)

  @ready_with_scope_all: (body_classes..., handler) =>
    @ready =>
      @with_scope_all(body_classes..., handler)

  @ready_with_scope_none: (body_classes..., handler) =>
    @ready =>
      @with_scope_none(body_classes..., handler)

  @ready_with_scope: (body_class, handler) =>
    @ready =>
      @with_scope(body_class, handler)

  @ready: (handler) =>
    $(document).on 'ready, page:change', ->
      handler()

  @data_js_on: (name, events, handler) =>
    $(document).on(events, "[data-js-#{ name }]", handler)

  @data_js: (name) =>
    $("[data-js-#{ name }]")

window.CMS = CMS
