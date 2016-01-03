module Admin
  module Form
    module Field
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          object_label_method do
            :rails_admin_label
          end

          edit do
            exclude_fields :structure, :fields
          end
        end
      end

      def rails_admin_label
        default_label.presence || position
      end
    end
  end
end
