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

            field :meta_general_image do
              def render
                bindings[:view].render partial: 'cms/shared/image',
                                       locals: { image: value,
                                                 image_field_name: 'viewable_page[meta_general_image]',
                                                 image_field_id: 'viewable_page_meta_general_image',
                                                 optimal_size: '1200×630'
                                       }
              end
            end

            field :og_title
            field :og_description

            field :og_image do
              def render
                bindings[:view].render partial: 'cms/shared/image',
                                       locals: { image: value,
                                                 image_field_name: 'viewable_page[og_image]',
                                                 image_field_id: 'viewable_page_og_image',
                                                 optimal_size: '1200×630'
                                       }
              end
            end


            field :twitter_card
            field :twitter_title
            field :twitter_description

            field :twitter_image do
              def render
                bindings[:view].render partial: 'cms/shared/image',
                                       locals: { image: value,
                                                 image_field_name: 'viewable_page[twitter_image]',
                                                 image_field_id: 'viewable_page_twitter_image',
                                                 optimal_size: '240×240'
                                       }
              end
            end

            field :has_show_page do
              label I18n.t('cms.page.has_show_page')
            end
          end

          nestable_tree({
            scope: :breadcrumb_appear,
            position_field: :tree_position,
            max_depth: 5
          })
        end
      end

      def name
        "#{title}"
      end
    end
  end
end
