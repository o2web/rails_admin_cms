module CMS
  module PageHelper
    def cms_page
      @cms_page
    end

    def self.define_cms_page_helpers(part)
      presenter = "CMS::#{part.to_s.capitalize}Presenter".constantize

      define_method "cms_page_#{part}" do |key = 'cms', min = nil, max = nil|
        return presenter.new(@cms_page.part_with_key(part, key), self) if min.nil?

        max = Float::INFINITY if max.nil? || max < min
        list = []
        @cms_page.parts_with_key(part, key, min).each{ |element| list.push presenter.new(element, self) }
        CMS::PageListPresenter.new(list, self, max)
      end

      define_method "cms_global_#{part}" do |key = 'cms', min = 1, max = nil|
        # validate_arguments! min, max
        presenter.new("CMS::#{part.to_s.capitalize}".constantize.global_with_key(key), self)
      end
    end

    ::CMS::Page::PARTS.each do |part|
      define_cms_page_helpers(part)
    end

    def validate_arguments!(min, max)
      if min == Float::INFINITY
        raise ArgumentError, "'min' can not be Float::INFINITY"
      end
      if max.nil?
        if min == 0
          raise ArgumentError, "if 'max' is not defined, 'min' must be greater than 0"
        end
      elsif max < 1
        raise ArgumentError, "'max' must be greater than 0 or nil"
      end
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
  end
end
