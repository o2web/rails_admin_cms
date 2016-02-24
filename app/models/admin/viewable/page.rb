module Admin
  module Viewable
    module Page
      extend ActiveSupport::Concern

      included do
        has_ancestry

        rails_admin do
          navigation_label I18n.t('cms.page.navigation')
          label I18n.t('cms.page.one')
          label_plural I18n.t('cms.page.other')

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

          edit do
            include_all_fields
            exclude_fields :position, :uuid, :ancestry
          end

          nestable_tree({
            position_field: :position
          })
        end
      end

      def name
        "#{title}"
      end
    end
  end
end
