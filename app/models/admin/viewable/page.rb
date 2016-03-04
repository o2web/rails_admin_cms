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
            label I18n.t('cms.page.url')
            pretty_value do
              (bindings[:object].show_link) ? bindings[:view].link_to(value, value, target: '_blank') : value
            end
          end

          field :title do
            label I18n.t('cms.page.title')
          end

          field :breadcrumb_appear do
            label I18n.t('cms.page.breadcrumb_appear')
          end

          field :show_link do
            label I18n.t('cms.page.show_link')
          end

          list do
            scopes [:localized]
          end

          create do
            field :available_templates, :enum do
              default_value do
                'app/views/cms/pages/page.html.erb'
              end
            end
            exclude_fields :title, :url, :breadcrumb_appear
          end

          edit do
            field :meta_title do
              label I18n.t('cms.page.meta_title')
            end

            field :meta_keywords do
              label I18n.t('cms.page.meta_keywords')
            end

            field :meta_description do
              label I18n.t('cms.page.meta_description')
            end

            field :has_show_page do
              label I18n.t('cms.page.has_show_page')
            end
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
