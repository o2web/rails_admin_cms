module Viewable
  class Form < ActiveRecord::Base
    include Viewable
    include Field::UUID
    include Field::Url
    include Admin::Viewable::Form

    belongs_to :structure, class_name: 'Form::Structure', dependent: :destroy
    has_many :rows, through: :structure, class_name: 'Form::Row'

    accepts_nested_attributes_for :structure, allow_destroy: true

    has_unlocalized_fields :structure

    class << self
      def static?(name)
        name.in? Naming::Viewable::Form.static_names
      end

      def not_static?(name)
        !static?(name)
      end
    end

    def form_name
      @_form_name ||= view_path.split('/')[-2]
    end

    def static?
      form_name.in? Naming::Viewable::Form.static_names
    end

    def not_static?
      !static?
    end

    def fetch_row(form)
      if structure.nil?
        create_structure!(viewable: self, email: ::Form::Email.new)
      end
      attributes = form.attributes
      attributes['structure_id'] = structure_id
      rows.build(attributes)
    end

    private

    def uuid_columns
      super + [:url]
    end

    module Splitter
      extend ActiveSupport::Concern

      included do
        before_destroy :assign_form_name_to_structure
      end

      private

      def assign_form_name_to_structure
        ::Form::Structure.form_name = self.form_name
      end
    end

    include Splitter
  end
end
