module Admin
  module Form
    module Structure
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          field :email
          field :fields do
            sortable true
          end
        end
      end
    end
  end
end
