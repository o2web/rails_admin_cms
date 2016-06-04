module CMS
  module PageHelper
    def cms_page
      @cms_page
    end

    def cms_page_text(key)
      @cms_page.text_with_key(key)
    end
  end
end
