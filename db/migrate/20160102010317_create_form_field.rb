class CreateFormField < ActiveRecord::Migration
  def change
    create_table :form_fields do |t|
      t.references :structure, index: true

      t.integer    :position
      t.string     :type
      t.boolean    :required, default: false

      I18n.available_locales.each do |locale|
        t.string   :"label_#{locale}"
      end

      t.timestamps null: false
    end
  end
end
