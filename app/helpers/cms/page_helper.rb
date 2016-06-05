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
        CMS::PageListPresenter.new(list, self, max, @cms_page.id)
      end

      define_method "cms_global_#{part}" do |key = 'cms', min = 1, max = nil|
        model = "CMS::#{part.to_s.capitalize}".constantize

        return presenter.new(model.global_with_key(key), self) if min.nil?

        max = Float::INFINITY if max.nil? || max < min
        list = []
        model.all_globals_with_key(key, min).each{ |element| list.push presenter.new(element, self) }
        CMS::PageListPresenter.new(list, self, max)
      end
    end

    ::CMS::Page::PARTS.each do |part|
      define_cms_page_helpers(part)
    end
  end
end
