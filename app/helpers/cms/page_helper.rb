module CMS
  module PageHelper
    def cms_page
      @cms_page
    end

    def cms_page_text(key)
      CMS::TextPresenter.new(@cms_page.text_with_key(key), self)
    end
  end
end
