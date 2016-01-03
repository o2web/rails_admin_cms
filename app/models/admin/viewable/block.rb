module Admin
  module Viewable
    module Block
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          object_label_method do
            :id
          end

          edit do
            group :default do
              hide
            end
          end
        end
      end
    end
  end
end
