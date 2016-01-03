module Admin
  module Viewable
    module Image
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          field :title
          field :image, :rich_picker do
            config scoped: 'cms'
          end
        end
      end
    end
  end
end
