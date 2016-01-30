module CMS
  module JavascriptHelper
    def cms_data_js(name, data = true, options = {})
      { "data-js-#{name}" => data.to_json }.merge(options)
    end

    def cms_data_js_html(name, data = true, options = {})
      CMS.options_to_html cms_data_js(name, data, options)
    end
  end
end
