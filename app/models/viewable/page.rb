module Viewable
  class Page < ActiveRecord::Base
    include Viewable
    include Field::UUID
    include Field::Url
    include Admin::Viewable::Page

    has_ancestry({
      cache_depth: true
    })

    after_commit :reload_routes_path

    attr_accessor :available_templates

    scope :breadcrumb_appear, -> { localized.where(breadcrumb_appear: true) }
    scope :with_page_url, -> { with_url.where(controller: 'pages', action: 'show', show_link: true) }
    scope :with_controller_url, -> { with_url.where(show_link: true).where.not(controller: 'pages', action: 'show') }
    scope :controller_routes, -> { joins(:unique_key).with_controller_url.where('unique_keys.locale = ?', I18n.locale) }

    after_update :set_tree_for_translations if :tree_position_changed? || :ancestry_changed?

    def set_tree_for_translations
      self.unique_key.other_locales.each do |key|

        translated_ancestors = []
        self.ancestry.split('/').each do |ancestor_id|
          ancestor_page = self.class.find(ancestor_id).unique_key.other_locale(key.locale).first
          translated_ancestors.push(ancestor_page.viewable.id)
        end if self.ancestry.present?

        key.viewable.update_columns(ancestry: translated_ancestors.present? ? translated_ancestors.join('/') : nil)
        key.viewable.update_columns(tree_position: self.tree_position)
        key.viewable.update_columns(ancestry_depth: self.ancestry_depth)
      end
    end

    def view_name
      @_view_name ||= view_path.split('/').last
    end

    def controller_name
      @_controller_name ||= controller.split('/').last
    end

    def single_controller_name
      @_single_controller_name ||= controller.split('/').last.singularize
    end

    def locale_controller_name
      @_locale_controller_name ||= "#{controller.split('/').last}_#{locale}"
    end

    def single_locale_controller_name
      @_single_locale_controller_name ||= "#{controller.split('/').last.singularize}_#{locale}"
    end

    def parent_at_depth(depth)
      roots = self.ancestors.at_depth(depth)
      roots.each do |child|
        return child if child.descendants.include? self
      end
      self
    end

    def available_templates_enum
      Dir.glob('app/views/cms/**/*.html.erb')
         .map{ |template| [template, template] if template.include?('cms/pages/') || self.template_exists?(template) }
    end

    def template_exists?(template)
      template.include?('index.html.erb') && self.existing_index_routes.exclude?(template.sub('app/views/', '').sub('.html.erb', ''))
    end

    def existing_index_routes
      self.class.includes(:unique_key).where(unique_keys: { viewable_type: 'Viewable::Page'}).where('unique_keys.view_path LIKE ?', '%/index').pluck(:view_path)
    end

    private

    def uuid_columns
      super + [:url]
    end

    def reload_routes_path
      self.class.controller_routes.each do |page|
        CMS::ViewableHelper.define_custom_route(page)
      end if ActiveRecord::Base.connection.table_exists? 'viewable_pages'
    end
  end
end
