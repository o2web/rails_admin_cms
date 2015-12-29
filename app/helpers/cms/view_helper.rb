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
      classes << 'cms-edit-mode' if edit_mode?
      classes.concat(args) if args.any?
      classes.compact.join(' ')
    end

    def cms_flash_messages(*args)
      content_tag :div, class: 'cms-flash-messages', 'data-cms-flash' => true do
        flash_messages(*args)
      end
    end
  end
end
