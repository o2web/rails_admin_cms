module Viewable
  class Page < ActiveRecord::Base
    include Viewable
    include Field::UUID
    include Field::Url
    include Admin::Viewable::Page

    def view_name
      @_view_name ||= view_path.split('/').last
    end

    private

    def uuid_columns
      super + [:url]
    end
  end
end
