module CMS
  module LocaleHelper
    def cms_locale_selector
      if RailsAdminCMS::Config.hide_current_locale?
        links = []
      else
        links = [ link_to(t('cms.locale_selector.language'), '#', class: 'active') ]
      end

      I18n.available_locales.reject{ |l| l == locale }.each do |locale|
        path = @cms_page.current_url_for(locale)
        links << link_to(t('cms.locale_selector.language', locale: locale), path)
      end

      content_tag(:ul, class: 'cms-locale-selector') do
        links.each do |link|
          concat content_tag(:li, link)
        end
      end
    end
  end
end
