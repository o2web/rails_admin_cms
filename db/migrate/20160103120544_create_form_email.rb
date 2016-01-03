class CreateFormEmail < ActiveRecord::Migration
  def change
    create_table :form_emails do |t|
      t.boolean  :with_email, default: false
      t.string   :send_to

      I18n.available_locales.each do |locale|
        t.string :"subject_#{locale}"
      end

      I18n.available_locales.each do |locale|
        t.text   :"body_#{locale}"
      end

      t.timestamps null: false
    end
  end
end
