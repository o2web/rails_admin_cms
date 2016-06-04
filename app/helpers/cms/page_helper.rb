module CMS
  module PageHelper
    def cms_page
      @cms_page
    end

    def self.define_cms_page_helpers(part)
      define_method "cms_page_#{part}" do |key = 'cms'|
        "CMS::#{part.to_s.capitalize}Presenter".constantize.new(@cms_page.part_with_key(part, key), self)
      end

      define_method "cms_global_#{part}" do |key = 'cms'|
        "CMS::#{part.to_s.capitalize}Presenter".constantize.new("CMS::#{part.to_s.capitalize}".constantize.global_with_key(key), self)
      end
    end

    ::CMS::Page::PARTS.each do |part|
      define_cms_page_helpers(part)
    end

      # access a Viewable within the current context
      # name(optional):
      # min (optional): defines how many viewables are created by default
      # max (optional): defines the limit of viewables that could added (must be greater than min)
      # * if min = 1, then a single ViewablePresenter is returned, otherwise, a ViewablePresenterList is returned
    #   define_method "cms_#{type}" do |name = 'cms', min = 1, max = nil| # max = FLOAT::INFINITY
    #     name, min, max = adjust_arguments(name, min, max)
    #
    #     validate_arguments! type, min, max
    #
    #     name, presenter = adjust_name_or_build_view_presenter type, name
    #
    #     return presenter if presenter
    #
    #     presenter_list = (1..min).map do |position|
    #       find_or_create_presenter(type, name, position)
    #     end
    #
    #     list_key = cms_list_key(type, name)
    #
    #     if max.nil?
    #       if min == 1
    #         return presenter_list.first
    #       else
    #         return build_list_presenter(presenter_list, list_key, max)
    #       end
    #     end
    #
    #     ((min + 1)..max).each do |position|
    #       if (presenter = find_presenter(type, name, position))
    #         presenter_list << presenter
    #       else
    #         break
    #       end
    #     end
    #
    #     build_list_presenter(presenter_list, list_key, max)
    #   end
    # end

    # def cms_page_text(key)
    #   CMS::TextPresenter.new(@cms_page.part_with_key(:text, key), self)
    # end
    #
    # def cms_page_string(key)
    #   CMS::PagePresenter.new(@cms_page.part_with_key(:string, key), self)
    # end
    #
    # def cms_page_image(key)
    #   CMS::ImagePresenter.new(@cms_page.part_with_key(:image, key), self)
    # end
    #
    # def cms_page_link(key)
    #   CMS::LinkPresenter.new(@cms_page.part_with_key(:link, key), self)
    # end
    #
    # def cms_page_select(key)
    #   CMS::SelectPresenter.new(@cms_page.part_with_key(:select, key), self)
    # end
  end
end
