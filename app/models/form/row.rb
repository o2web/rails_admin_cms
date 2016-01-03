module Form
  class Row < ActiveRecord::Base
    include Form
    include Admin::Form::Row

    self.table_name_prefix = 'form_'

    belongs_to :structure
    has_many :fields, through: :structure
    has_one :viewable, through: :structure, class_name: 'Viewable::Form'

    validates :structure, presence: true

    delegate :send_email?, :send_to, :send_subject, :email_column_key, :header, to: :structure
    delegate :form_name, to: :viewable

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
  end
end
