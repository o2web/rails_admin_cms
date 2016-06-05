class CMS::PageListPresenter < BasePresenter
  def initialize(list, context, max, page_id = nil)
    super(list, context)
    @max = max
    @list = list
    @page_id = page_id
  end

  def edit_links(method_name = nil)
    return unless h.cms_edit_mode?

    h.content_tag(:ul, sortable(class: "cms-wrapped-edit")) do
      list.each.with_index(1) do |m, i|
        name = method_name ? m.__send__(method_name) : i
        h.concat(h.content_tag(:li, h.cms_data_js('cms-sortable-id', m.unique_key.id)) do
          m.edit_link(name)
        end)
      end
      h.concat h.content_tag(:li, add_link)
    end
  end

  def add_link
    return unless h.cms_edit_mode?
    return unless @max == Float::INFINITY || @list.size < @max.to_i

    h.link_to add_path, class: "cms-add", 'data-no-turbolink' => true do
      h.concat h.content_tag(:span, h.t('cms.add'), class: "cms-add-action")
    end
  end

  def sortable(options = {})
    if h.cms_edit_mode?
      h.cms_data_js('cms-sortable', { url: h.main_app.edit_viewable_url(format: :js) }, options)
    else
      options
    end
  end

  def sortable_html(options = {})
    CMS.options_to_html sortable(options)
  end

  def ul_sortable_tag(options = {})
    h.content_tag :ul, sortable(options) do
      yield
    end
  end

  private

  def add_path
    h.create_list_part_path model: @list.first.model.class.name, key: @list.first.key, page_id: @page_id, position: @list.size + 1, locale: ::I18n.locale
  end
end