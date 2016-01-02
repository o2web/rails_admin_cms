module Admin
  module Viewable
    module Form
      extend ActiveSupport::Concern

      included do
        rails_admin do
          navigation_label I18n.t('cms.form.navigation')
          label I18n.t('cms.form.one')
          label_plural I18n.t('cms.form.other')

          field :structure
          field :url, :string
          field :title
          fields :meta_keywords, :meta_description

          list do
            scopes [:localized]
          end
        end
      end
    end
  end
end
