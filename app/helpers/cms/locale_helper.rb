module CMS
  module LocaleHelper
    def cms_locale_selector
      if controller_path.match /^cms\/(pages|forms)$/
        generate_locale_selector do |locale|
          main_app.__send__("#{params[:id]}_#{locale}_path")
        end
      else
        generate_locale_selector do |locale|
          url_for(:locale => locale.to_s)
        end
      end
    end

    private

    def generate_locale_selector(&block)
      links = [ link_to(t('cms.locale_selector.language'), '#', class: 'active') ]

      I18n.available_locales.reject{ |l| l == locale }.each do |locale|
        path = block.call(locale)
        links << link_to(t('cms.locale_selector.language', locale: locale), path)
      end

      content_tag(:ul) do
        links.each do |link|
          concat content_tag(:li, link)
        end
      end
    end
  end
end
