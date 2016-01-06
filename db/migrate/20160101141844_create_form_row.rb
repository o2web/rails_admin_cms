class CreateFormRow < ActiveRecord::Migration
  def change
    create_table :form_rows do |t|
      t.references :structure, index: true
      t.string     :locale

      RailsAdminCMS::Config.custom_form_max_size.times.each do |i|
        t.text     :"column_#{i}"
      end

      t.timestamps null: false
    end
  end
end
