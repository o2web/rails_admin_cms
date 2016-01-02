module Form
  class Field < ActiveRecord::Base
    include Admin::Form::Field

    self.table_name_prefix = 'form_'
    self.inheritance_column = nil

    belongs_to :structure, touch: true

    acts_as_list scope: :structure, top_of_list: 0

    after_update :update_header, if: :default_label_changed?

    def column_key
      :"column_#{position}"
    end

    def label
      send("label_#{I18n.locale}")
    end

    def default_label
      send("label_#{I18n.default_locale}")
    end

    def input_type
      type.demodulize.underscore.to_sym
    end

    def type_enum
      [:string, :text, :email]
    end

    class << self
      def names
        @_names ||= CMS.rb_all_names('app/models/form/field').map(&:to_sym)
      end
    end

    private

    def default_label_changed?
      send("label_#{I18n.default_locale}_changed?")
    end

    def update_header
      structure.header.update! column_key => default_label
    end
  end
end
