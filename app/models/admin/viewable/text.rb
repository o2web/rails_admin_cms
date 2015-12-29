module Admin
  module Viewable
    module Text
      extend ActiveSupport::Concern

      included do
        rails_admin do
          visible false

          field :title
          field :text, :rich_editor
        end
      end
    end
  end
end
