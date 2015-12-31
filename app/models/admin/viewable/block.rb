module Admin
  module Viewable
    module Block
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          edit do
            field :name do
              read_only true
            end
          end
        end
      end
    end
  end
end
