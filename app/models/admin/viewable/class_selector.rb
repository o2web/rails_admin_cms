module Admin
  module Viewable
    module ClassSelector
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          field :main_class
          field :extra_classes
        end
      end
    end
  end
end
