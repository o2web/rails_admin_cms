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

      def page_enum
        static = ::Viewable.pages
        paths = static.map do |template|
          Rails.application.routes.url_helpers.send "#{template}_path"
        end
        paths.sort
      end
    end
  end
end
