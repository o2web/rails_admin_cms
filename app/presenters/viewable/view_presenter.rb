module Viewable
  class ViewPresenter < ViewablePresenter
    def initialize(model, context)
      super
      set_cms_view
      set_meta_tags
    end

    def add_link
      return unless h.cms_edit_mode?

      h.link_to add_path, class: "cms-add cms-add-page", 'data-no-turbolink' => true do
        h.concat h.content_tag(:span, h.t('cms.add'), class: "cms-add-action")
      end
    end

    private

    def set_cms_view
      h.instance_variable_set :@cms_view, self
    end

    def set_meta_tags
      tags = %w[
        title
        meta_keywords
        meta_description
      ]
      tags.each do |tag|
        h.instance_variable_set("@cms_page_#{tag}", m.send(tag).presence)
      end
    end

    def add_path
      h.main_app.new_viewable_url(list_key: h.cms_list_key(short_type, m.unique_key_name), max: Float::INFINITY)
    end

    def short_type
      m.viewable_type.demodulize.underscore
    end
  end
end
