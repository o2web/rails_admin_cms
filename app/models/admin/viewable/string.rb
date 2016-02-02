module Admin
  module Viewable
    module String
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          field :string
        end
      end
    end
  end
end
