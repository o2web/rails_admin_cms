module Admin
  module Form
    module Structure
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          fields :send_email, :send_to, *I18n.available_locales.map{ |l| :"send_subject_#{l}" }
          field :fields do
            sortable true
          end
        end
      end
    end
  end
end
