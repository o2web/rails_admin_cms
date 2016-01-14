module CMS
  module JavascriptHelper
    def cms_data_js(name, data = true, options = {})
      { "data-js-#{name}" => data.to_json }.merge(options)
    end
  end
end
