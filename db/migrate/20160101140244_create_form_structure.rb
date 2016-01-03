class CreateFormStructure < ActiveRecord::Migration
  def change
    create_table :form_structures do |t|
      t.references :email, index: true

      t.timestamps null: false
    end
  end
end
