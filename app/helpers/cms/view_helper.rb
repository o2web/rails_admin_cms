module CMS
  module ViewHelper
    def cms_body_class(*args)
      controller_name = controller_path.gsub('/','-')
      classes = [
        params[:cms_view_type],
        controller_name,
        "#{controller_name}-#{action_name}",
        ::I18n.locale,
      ]
      classes << 'cms-edit-mode' if cms_edit_mode?
      classes.concat(args) if args.any?
      classes.compact.join(' ')
    end

    def cms_flash_messages(*args)
      content_tag :div, cms_data_js('cms-flash', true, class: 'cms-flash-messages') do
        flash_messages(*args)
      end
    end

    def cms_title(title = nil)
      return title unless defined? @cms_view
      "#{content_priority([@cms_view.meta_title, @cms_view.title, ::Setting["default_meta_title_#{::I18n.locale}"]])} - #{::I18n.t('site.title')}".html_safe
    end

    def cms_meta_data_tags
      return meta_data_tags unless defined? @cms_view
      html = tag(:meta, name: 'description', content: content_priority([@cms_view.meta_description, ::Setting["default_meta_description_#{::I18n.locale}"]]))
      html << tag(:meta, name: 'keywords', content: content_priority([@cms_view.meta_keywords, ::Setting["default_meta_keywords_#{::I18n.locale}"]]))
      html << tag(:meta, name: 'twitter:site', content: ::Setting["twitter_site_#{::I18n.locale}"])
      html << tag(:meta, name: 'twitter:card', content: content_priority([@cms_view.twitter_card, ::Setting["default_twitter_card_#{::I18n.locale}"]]))
      html << tag(:meta, name: 'twitter:title', content: content_priority([@cms_view.twitter_title, ::Setting["default_twitter_title_#{::I18n.locale}"]]))
      html << tag(:meta, name: 'twitter:image',content: "#{request.base_url}#{content_priority([@cms_view.twitter_image, @cms_view.meta_general_image, ::Setting["default_meta_general_image_#{::I18n.locale}"]])}")
      html << tag(:meta, property: 'og:title', content: content_priority([@cms_view.og_title, ::Setting["default_og_title_#{::I18n.locale}"]]))
      html << tag(:meta, property: 'og:image', content: "#{request.base_url}#{content_priority([@cms_view.og_image, @cms_view.meta_general_image, ::Setting["default_meta_general_image_#{::I18n.locale}"]])}")
      html << tag(:meta, property: 'og:description', content: content_priority([@cms_view.og_description, ::Setting["default_og_description_#{::I18n.locale}"]]))
      html << tag(:meta, property: 'fb:app_id', content: ::Setting["fb_app_id_#{::I18n.locale}"])

      html.html_safe
    end

    def content_priority(content)
      content.each do |element|
        return element if element.present?
      end
      ''
    end

    def hreflang_links
      html = ''
      ::I18n.available_locales.each do |locale|
        html << tag(:link, rel: 'alternate', hreflang: locale, href: "#{request.base_url}#{current_url_for(locale)}")
      end
      html
    end

    def yes_no(boolean)
      boolean ? t('yes') : t('no')
    end

    def to_nbsp(value)
      value.kind_of?(String) ? value.gsub(' ', '&nbsp;').gsub('-', '&#8209;') : (value || '')
    end

    def to_currency(value)
      number_to_currency(value, separator: '.', delimiter: '', format: '%n $')
    end

    def to_int_if_whole(float)
      (float % 1 == 0) ? float.to_i : float
    end

    def full_name(object, prefix = nil)
      if prefix
        "#{object.send("#{prefix}_firstname")} #{object.send("#{prefix}_lastname")}"
      else
        "#{object.firstname} #{object.lastname}"
      end
    end

    def current_url_without_params
      "#{request.base_url}#{request.path}"
    end
  end
end
