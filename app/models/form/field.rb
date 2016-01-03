module Form
  class Field < ActiveRecord::Base
    include Admin::Form::Field

    TYPES ||= %w[ string text email ]

    self.table_name_prefix = 'form_'
    self.inheritance_column = nil

    belongs_to :structure, touch: true
    has_many :fields, through: :structure

    delegate :count, to: :fields, prefix: true
    delegate :header, to: :structure

    after_create ::Callbacks::Form::FieldAfterCreate.new
    after_destroy ::Callbacks::Form::FieldAfterDestroy.new
    before_update ::Callbacks::Form::FieldBeforeUpdate.new, if: :position_changed?
    after_update :update_column_header, if: :default_label_changed_but_not_position?

    with_options presence: true do
      validates :type, inclusion: { in: TYPES }
      validates :structure
      validates :position, numericality: { greater_than_or_equal_to: 0}
      with_options on: :create do
        validates :position, numericality: { less_than_or_equal_to: :fields_count }
      end
      with_options on: :update do
        validates :position, numericality: { less_than: :fields_count }
      end
    end

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
      TYPES
    end

    def update_header
      attributes = RailsAdminCMS::Config.custom_form_max_size.times.map do |i|
        [:"column_#{i}", '']
      end.to_h

      fields.map do |field|
        attributes[field.column_key] = field.default_label
      end

      header.update! attributes
    end

    private

    def default_label_changed_but_not_position?
      send("label_#{I18n.default_locale}_changed?") && !position_changed?
    end

    def update_column_header
      header.update! column_key => default_label
    end
  end
end
