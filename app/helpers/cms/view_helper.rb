module CMS
  module ViewHelper
    def cms_body_class(*args)
      controller_name = controller_path.gsub('/','-')
      classes = [ params[:cms_body_class], controller_name, "#{controller_name}-#{action_name}", I18n.locale ]
      classes.concat(args) if args.any?
      classes.compact.join(' ')
    end
  end
end
