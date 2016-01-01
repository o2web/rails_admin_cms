module Admin
  module Viewable
    module Link
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          field :title
          field :url, :string
          field :page
          field :file, :rich_picker do
            config type: :file, allowed_styles: [:original], scoped: 'cms'
          end
          fields :target_blank, :turbolink
        end
      end
    end
  end
end
