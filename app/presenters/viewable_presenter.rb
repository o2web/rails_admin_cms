class ViewablePresenter < BasePresenter
  def edit_link(name = nil)
    return unless h.cms_edit_mode?

    h.link_to edit_path, class: "cms-edit cms-edit-#{m.dashed_name}", 'data-no-turbolink' => true do
      h.concat h.content_tag(:span, h.t('cms.edit'), class: "cms-edit-action")
      h.concat " "
      h.concat h.content_tag(:span, name, class: "cms-edit-name")
    end
  end

  def li_sortable_tag(options = nil)
    options ||= {}
    if h.cms_edit_mode?
      options['data-cms-sortable-id'] = m.unique_key.id
    end
    h.content_tag :li, options do
      yield
    end
  end

  private

  def edit_path
    h.rails_admin.edit_path(model_name: m.class.name.underscore.gsub('/', '~'), id: m.id)
  end
end