module Admin
  module Form
    module Structure
      extend ActiveSupport::Concern

      included do
        rails_admin do
          object_label_method do
            :rails_admin_label
          end

          fields :send_email, :send_to, *I18n.available_locales.map{ |l| :"send_subject_#{l}" }
          field :fields do
            sortable true
          end
        end
      end

      def rails_admin_label
        label = viewable.try(:form_name).presence
        if label
          "#{label}-#{id}"
        else
          id
        end
      end
    end
  end
end
