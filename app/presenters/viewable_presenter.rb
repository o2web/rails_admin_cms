class ViewablePresenter < BasePresenter
  def edit_link(name = nil)
    return unless h.cms_edit_mode?

    h.link_to edit_path, class: "cms-edit cms-edit-#{dashed_name}", 'data-no-turbolink' => true do
      h.concat h.content_tag(:span, h.t('cms.edit'), class: "cms-edit-action")
      h.concat " "
      h.concat h.content_tag(:span, name, class: "cms-edit-name")
    end
  end

  def li_sortable_tag(options = nil)
    options ||= {}
    if h.cms_edit_mode?
      options = h.cms_js_element('cms-sortable-id', m.unique_key.id, options)
    end
    h.content_tag :li, options do
      yield
    end
  end

  private

  def edit_path
    h.rails_admin.edit_path(model_name: m.class.name.underscore.gsub('/', '~'), id: m.id)
  end

  def dashed_name
    @_dashed_name ||= underscored_name.dasherize
  end

  def underscored_name
    @_underscored_name ||= m.class.name.underscore.gsub('/', '_')
  end
end