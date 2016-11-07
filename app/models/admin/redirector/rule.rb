module Admin
  module Redirector
    module Rule
      extend ActiveSupport::Concern

      included do
        rails_admin do
          navigation_label I18n.t('cms.redirector.navigation')
          label I18n.t('cms.redirector.one')
          label_plural I18n.t('cms.redirector.other')

          list do
            field :id
            field :active
            field :source
            field :destination
          end

          edit do
            field :active
            field :source_is_regex
            field :source_is_case_sensitive
            field :source
            field :destination
          end
        end
      end
    end
  end
end