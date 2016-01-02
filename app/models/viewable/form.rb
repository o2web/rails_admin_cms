module Viewable
  class Form < ActiveRecord::Base
    include Viewable
    include Field::UUID
    include Field::Url
    include Admin::Viewable::Form

    belongs_to :structure, class_name: 'Form::Structure'
    has_many :rows, through: :structure, class_name: 'Form::Row'

    has_unlocalized_fields :structure

    class << self
      def names
        @_names ||= CMS.dir_names 'app/views/cms/forms'
      end

      def static_names
        @_static_names ||= CMS.rb_names 'app/models/form'
      end

      def static?(name)
        name.in? static_names
      end

      def not_static?(name)
        !static?(name)
      end
    end

    def form_name
      @_form_name ||= view_path.split('/')[-2]
    end

    def static?
      form_name.in? self.class.static_names
    end

    def not_static?
      !static?
    end

    private

    def uuid_columns
      super + [:url]
    end
  end
end
