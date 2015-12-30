class CreateViewableSelect < ActiveRecord::Migration
  def change
    create_table :viewable_selects do |t|
      t.string     :value
      t.string     :label

      t.timestamps null: false
    end
  end
end
