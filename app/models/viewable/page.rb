module Viewable
  class Page < ActiveRecord::Base
    include Viewable
    include Field::UUID
    include Field::Url
    include Admin::Viewable::Page

    has_ancestry

    attr_accessor :available_templates

    scope :breadcrumb_appear, -> { localized.where(breadcrumb_appear: true) }

    after_update :set_tree_for_translations if :position_changed? || :ancestry_changed?


    def set_tree_for_translations
      self.unique_key.other_locales.each do |key|

        translated_ancestors = []
        self.ancestry.split('/').each do |ancestor_id|
          ancestor_page = self.class.find(ancestor_id).unique_key.other_locale(key.locale).first
          translated_ancestors.push(ancestor_page.viewable.id)
        end if self.ancestry.present?

        key.viewable.update_columns(ancestry: translated_ancestors.present? ? translated_ancestors.join('/') : nil)
        key.viewable.update_columns(tree_position: self.tree_position)
      end

    end

    def view_name
      @_view_name ||= view_path.split('/').last
    end

    def second_level_root
      root.children.each do |child|
        return child if child.descendants.include? self
      end
    end

    def available_templates_enum
      Dir.glob('app/views/cms/**/*.html.erb')
         .map{ |template| [template, template] if template.include?('cms/pages/') || template.include?('index') }
    end

    private

    def uuid_columns
      super + [:url]
    end
  end
end
