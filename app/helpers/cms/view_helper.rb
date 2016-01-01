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
      content_tag :div, class: 'cms-flash-messages', 'data-cms-flash' => true do
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
  end
end
