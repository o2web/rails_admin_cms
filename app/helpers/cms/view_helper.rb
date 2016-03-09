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

    def cms_title(default = nil)
      (@cms_page_meta_title || @cms_page_title) || default
    end

    def cms_meta_data_tags(default = nil)
      if @cms_page_meta_keywords || @cms_page_meta_description
        html = tag(:meta, name: 'keywords', content: @cms_page_meta_keywords)
        html << "\n"
        html << tag(:meta, name: 'description', content: @cms_page_meta_description)
        html.html_safe
      else
        default
      end
    end

    def cms_meta_og_tags(default = nil)
      tags = {}
      tags[:title] = @product ? @product.name : cms_title
      tags[:type] = 'website'
      tags[:description] = @product ? @product.description : @cms_page_meta_description
      tags[:url] = @product ? product_url(@product, only_path: false) : request.original_url
      tags[:image] = @product ? @product.images.first.try(:attachment).try(:url, :product) : nil # @todo image

      html = ''
      tags.each do |name, value|
        html << tag(:meta, property: "og:#{name}", content: value)
        html << "\n"
      end
      html.html_safe || default
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
