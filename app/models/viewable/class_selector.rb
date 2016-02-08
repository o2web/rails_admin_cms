module Viewable
  class ClassSelector < ActiveRecord::Base
    include Viewable
    include Admin::Viewable::ClassSelector

    has_unlocalized_fields :unlocalized_fields

    def unlocalized_fields
      [:main_class, :extra_classes]
    end

    def main_class_enum
      RailsAdminCMS::Config.class_list ||= []
    end
  end
end
