module Admin
  module Viewable
    module Select
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          fields :value, :label
        end
      end
    end
  end
end
