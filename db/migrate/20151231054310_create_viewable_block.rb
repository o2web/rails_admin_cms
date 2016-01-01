class CreateViewableBlock < ActiveRecord::Migration
  def change
    create_table :viewable_blocks do |t|
      t.string     :uuid
      t.string     :title

      t.timestamps null: false
    end
  end
end
