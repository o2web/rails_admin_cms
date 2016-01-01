module Admin
  module Setting
    extend ActiveSupport::Concern

    included do
      rails_admin do
        navigation_label I18n.t('cms.setting.navigation')
        label I18n.t('cms.setting.one')
        label_plural I18n.t('cms.setting.other')

        edit do
          field :name do
            read_only true
          end
          field :value, :string
          field :unit
        end
      end
    end
  end
end
