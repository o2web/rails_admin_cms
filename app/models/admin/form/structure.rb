module Admin
  module Form
    module Structure
      extend ActiveSupport::Concern

      included do
        rails_admin do

        end
      end
    end
  end
end
