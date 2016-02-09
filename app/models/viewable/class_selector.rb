module Viewable
  class ClassSelector < ActiveRecord::Base
    include Viewable
    include Admin::Viewable::ClassSelector

    has_unlocalized_fields :main_class, :extra_classes

    def main_class_enum
      RailsAdminCMS::Config.class_list
    end
  end
end
