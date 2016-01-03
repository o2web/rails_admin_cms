module Admin
  module Viewable
    module Form
      extend ActiveSupport::Concern

      included do
        rails_admin do
          navigation_label I18n.t('cms.form.navigation')
          label I18n.t('cms.form.one')
          label_plural I18n.t('cms.form.other')

          field :structure do
            pretty_value do
              h = bindings[:view]
              p = ViewablePresenter.new value, h
              h.link_to value.name, p.__send__(:edit_path)
            end

            inline_add false
          end
          field :url, :string do
            pretty_value do
              bindings[:view].link_to value, value, target: '_blank'
            end
          end
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
