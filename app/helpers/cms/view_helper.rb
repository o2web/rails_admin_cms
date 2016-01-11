module CMS
  module ViewHelper
    def cms_body_class(*args)
      controller_name = controller_path.gsub('/','-')
      classes = [
        params[:cms_body_class],
        controller_name,
        "#{controller_name}-#{action_name}",
        I18n.locale,
      ]
      classes << 'cms-edit-mode' if cms_edit_mode?
      classes.concat(args) if args.any?
      classes.compact.join(' ')
    end

    def cms_flash_messages(*args)
      content_tag :div, cms_js_element('cms-flash', true, class: 'cms-flash-messages') do
        flash_messages(*args)
      end
    end

    def cms_title(default = nil)
      @cms_page_title || default
    end

    def cms_meta_data_tags(default = nil)
      if @cms_page_meta_keywords || @cms_page_meta_description
        html = tag(:meta, name: 'meta_keywords', content: @cms_page_meta_keywords)
        html << "\n"
        html << tag(:meta, name: 'meta_description', content: @cms_page_meta_description)
        html.html_safe
      else
        default
      end
    end

    def cms_meta_og_tags(title = nil)
      tags = {}
      if @product # TODO: move to Solidus connector
        tags[:title] = @product.name
        tags[:description] = @product.description
        tags[:url] = product_url(@product, only_path: false)
        image = @product.images.first.try(:attachment)
        tags[:image] = image.try(:url, :product)
      else
        tags[:title] = title.blank? ? Setting['cms_og_tag_title'] : title
      end
      %{
        <meta property="og:title" content="#{tags[:title]}" />
        <meta property="og:type" content="website" />
        <meta property="og:description" content="#{tags[:description] || Setting['cms_og_tag_description']}" />
        <meta property="og:url" content="#{tags[:url] || request.original_url }" />
        <meta property="og:image" content="#{image_url(tags[:image] || 'ogimage.jpg', only_path: false)}" />
      }.html_safe
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
