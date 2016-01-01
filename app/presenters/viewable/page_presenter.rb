module Viewable
  class PagePresenter < ViewablePresenter
    def initialize(model, context)
      super
      set_meta_tags
    end

    def add_link
      return unless h.cms_edit_mode?

      h.link_to add_path, class: "cms-add cms-add-page", 'data-no-turbolink' => true do
        h.t('cms.add_page')
      end
    end

    private

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
      h.main_app.new_viewable_url(list_key: h.cms_list_key('page', m.unique_key_name), max: Float::INFINITY)
    end
  end
end
