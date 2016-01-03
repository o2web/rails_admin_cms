module Admin
  module Viewable
    module Block
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          object_label_method do
            :rails_admin_label
          end

          group :default do
            hide
          end
        end
      end

      def rails_admin_label
        "#{partial_name}-#{id}"
      end
    end
  end
end
