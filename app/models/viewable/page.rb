module Viewable
  class Page < ActiveRecord::Base
    include Viewable
    include Field::UUID
    include Field::Url
    include Admin::Viewable::Page

    scope :breadcrumb_appear, -> { localized.where(breadcrumb_appear: true) }

    after_save :set_tree_for_translations if :position_changed? || :ancestry_changed?

    def set_tree_for_translations
      self.unique_key.other_locales.each do |key|
        key.viewable.update_columns(tree_position: tree_position)
      end
    end

    def view_name
      @_view_name ||= view_path.split('/').last
    end

    private

    def uuid_columns
      super + [:url]
    end
  end
end
