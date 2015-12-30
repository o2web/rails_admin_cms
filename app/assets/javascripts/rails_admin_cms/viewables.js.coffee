#= require jquery-ui/sortable

CMS.ready_with_scope 'cms-edit-mode', ->
  $('[data-cms-sortable]').each ->
    $(this).sortable
      update: (event, ui) ->
        url = $(this).data('cms-sortable')['url']

        target = $(ui.item)
        id = target.data('cms-sortable-id')
        unique_key = { position: target.index() + 1 }
        payload = $.param(id: id, unique_key: unique_key)

        $.post(url, payload)
