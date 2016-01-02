class CreateFormStructure < ActiveRecord::Migration
  def change
    create_table :form_structures do |t|
      t.boolean  :send_email, default: false
      t.string   :send_to

      I18n.available_locales.each do |locale|
        t.string :"send_subject_#{locale}"
      end

      t.timestamps null: false
    end
  end
end
