module Form
  class Row < ActiveRecord::Base
    include Form
    include Admin::Form::Row

    self.table_name_prefix = 'form_'

    belongs_to :structure
    has_many :fields, through: :structure
    has_one :viewable, through: :structure, class_name: 'Viewable::Form'

    validates :structure, presence: true

    delegate :with_email?, :send_to, :subject, :body, :email_column_key, :header, to: :structure
    delegate :form_name, to: :viewable

    def js_form_selector
      "#new_form_#{model_name.element}"
    end

    def send_from
      send(email_column_key) if email_column_key
    end

    def labelled_values
      columns = fields.count.times.map{ |i| "column_#{i}" }
      values = header.attributes.slice(*columns)
      values.reduce({}) do |values, (column_key, label)|
        values[label] = send(column_key)
        values
      end
    end

    def locale_enum
      I18n.available_locales
    end
  end
end
