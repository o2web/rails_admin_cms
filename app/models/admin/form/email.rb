module Admin
  module Form
    module Email
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          object_label_method do
            :rails_admin_label
          end

          edit do
            toolbar = Rich.editor[:toolbar].deep_dup
            toolbar.delete_at(-2)

            if RailsAdminCMS::Config.with_email_body?
              I18n.available_locales.each do |locale|
                configure :"body_#{locale}", :rich_editor do
                  config(toolbar: toolbar)
                end
              end
              exclude_fields :structure
            else
              exclude_fields :structure, *I18n.available_locales.map{ |l| :"body_#{l}" }
            end
          end
        end
      end

      def rails_admin_label
        if with_email?
          '<i class="icon-ok"></i>'
        else
          '<i>-</i>'
        end.html_safe
      end
    end
  end
end
