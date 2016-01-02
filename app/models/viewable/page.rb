module Viewable
  class Page < ActiveRecord::Base
    include Viewable
    include Viewable::Field::UUID
    include Viewable::Field::Url
    include Admin::Viewable::Page

    class << self
      def names
        @_names ||= Dir["#{Rails.root}/app/views/cms/pages/*.html.*"].map do |name|
          File.basename(name).sub(/\.html\..+$/, '')
        end
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
