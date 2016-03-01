module Admin
  module Viewable
    module Page
      extend ActiveSupport::Concern

      included do

        rails_admin do
          navigation_label I18n.t('cms.page.navigation')
          label I18n.t('cms.page.one')
          label_plural I18n.t('cms.page.other')

          field :url, :string do
            pretty_value do
              bindings[:view].link_to value, value, target: '_blank'
            end
          end

          fields :title, :meta_keywords, :meta_description, :breadcrumb_appear, :has_show_page, :show_link

          list do
            scopes [:localized]
          end

          create do
            field :available_templates, :enum do
              default_value do
                'app/views/cms/pages/page.html.erb'
              end
            end
            exclude_fields :title, :url, :meta_keywords, :meta_description, :breadcrumb_appear, :has_show_page, :show_link
          end

          edit do
            field :breadcrumb_appear
            field :has_show_page
          end

          nestable_tree({
            scope: :breadcrumb_appear,
            position_field: :tree_position,
            max_depth: 4
          })
        end
      end

      def name
        "#{title}"
      end
    end
  end
end
