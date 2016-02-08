class CreateViewableClassSelector < ActiveRecord::Migration
  def change
    create_table :viewable_class_selectors do |t|
      t.string     :main_class
      t.string     :extra_classes

      t.timestamps null: false
    end
  end
end