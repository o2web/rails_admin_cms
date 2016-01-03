module Admin
  module Viewable
    module Page
      extend ActiveSupport::Concern

      included do
        rails_admin do
          navigation_label I18n.t('cms.page.navigation')
          label I18n.t('cms.page.one')
          label_plural I18n.t('cms.page.other')

          field :url, :string
          field :title
          fields :meta_keywords, :meta_description

          configure :url do
            pretty_value do
              bindings[:view].link_to value, value, target: '_blank'
            end
          end

          list do
            scopes [:localized]
          end
        end
      end
    end
  end
end
