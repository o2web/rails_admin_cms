class CreateSetting < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name
      t.text   :value
      t.string :unit

      t.timestamps null: false
    end

    add_index :settings, :name, unique: true
  end
end
