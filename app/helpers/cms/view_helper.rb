module CMS
  module ViewHelper
    def cms_body_class(*args)
      controller_name = controller_path.gsub('/','-')
      classes = [
        params[:cms_view_type],
        controller_name,
        "#{controller_name}-#{action_name}",
        I18n.locale,
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

    def cms_title
      ((@cms_view.meta_title.present? ? @cms_view.meta_title : @cms_view.title) || Setting['default_meta_title']).html_safe
    end

    def cms_meta_data_tags
      html = tag(:meta, name: 'description', content: (@cms_view.meta_description.present? ? @cms_view.meta_description : Setting['default_meta_description']))
      html << tag(:meta, name: 'keywords', content: (@cms_view.meta_keywords.present? ? @cms_view.meta_keywords : Setting['default_meta_description']))
      html << tag(:meta, name: 'twitter:site', content: Setting['twitter_site'])
      html << tag(:meta, name: 'twitter:card', content: (@cms_view.twitter_card.present? ? @cms_view.twitter_card : Setting['default_twitter_card']))
      html << tag(:meta, name: 'twitter:title', content: (@cms_view.twitter_title.present? ? @cms_view.twitter_title : Setting['default_twitter_title']))
      html << tag(:meta, name: 'twitter:image', content: (@cms_view.twitter_image.present? ? @cms_view.twitter_image : (@cms_view.meta_general_image.present? ? @cms_view.meta_general_image : Setting['default_meta_general_image'])))
      html << tag(:meta, property: 'og:title', content: (@cms_view.og_title.present? ? @cms_view.og_title : Setting['default_og_title']))
      html << tag(:meta, property: 'og:image', content: (@cms_view.og_image.present? ? @cms_view.og_image : (@cms_view.meta_general_image.present? ? @cms_view.meta_general_image : Setting['default_meta_general_image'])))
      html << tag(:meta, property: 'og:description', content: (@cms_view.og_description.present? ? @cms_view.og_description : Setting['default_og_description']))
      html << tag(:meta, property: 'fb:app_id', content: Setting['fb_app_id'])

      html.html_safe
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
