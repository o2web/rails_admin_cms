module CMS
  module LocaleHelper
    def cms_locale_selector
      links = [ link_to(t('cms.locale_selector.language'), '#', class: 'active') ]

      I18n.available_locales.reject{ |l| l == locale }.each do |locale|
        path = current_url_for(locale)
        links << link_to(t('cms.locale_selector.language', locale: locale), path)
      end

      content_tag(:ul) do
        links.each do |link|
          concat content_tag(:li, link)
        end
      end
    end

    private

    def current_url_for(locale)
      url = case controller_path
      when /^cms\/pages/
        if @page
          @page.other_uuid(locale).try(:url)
        else
          main_app.try("#{params[:page]}_#{locale}_path")
        end
      when /^cms\/forms/
        main_app.try("#{params[:form]}_#{locale}_path")
      else
        url_for(:locale => locale.to_s)
      end
      url.presence || main_app.root_path(locale: locale)
    end
  end
end
