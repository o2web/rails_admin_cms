module Admin
  module Form
    module Field
      extend ActiveSupport::Concern

      included do
        rails_admin do

        end
      end
    end
  end
end
