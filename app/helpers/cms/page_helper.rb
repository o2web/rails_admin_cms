module CMS
  module PageHelper
    def cms_page
      @cms_page
    end

    def cms_page_text(key)
      CMS::TextPresenter.new(@cms_page.part_with_key(:text, key), self)
    end

    def cms_page_string(key)
      CMS::PagePresenter.new(@cms_page.part_with_key(:string, key), self)
    end

    def cms_page_image(key)
      CMS::ImagePresenter.new(@cms_page.part_with_key(:image, key), self)
    end

    def cms_page_link(key)
      CMS::LinkPresenter.new(@cms_page.part_with_key(:link, key), self)
    end

    def cms_page_select(key)
      CMS::SelectPresenter.new(@cms_page.part_with_key(:select, key), self)
    end
  end
end
