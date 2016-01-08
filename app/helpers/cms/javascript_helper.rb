module CMS
  module JavascriptHelper
    def cms_js_element(name, data = true, options = {})
      { "data-js-#{name}" => data.to_json }.merge(options)
    end
  end
end
