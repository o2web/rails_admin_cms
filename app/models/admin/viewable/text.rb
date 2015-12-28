module Admin
  module Viewable
    module Text
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          field :title
          field :html, :rich_editor
        end
      end
    end
  end
end
