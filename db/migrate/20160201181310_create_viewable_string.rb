class CreateViewableString < ActiveRecord::Migration
  def change
    create_table :viewable_strings do |t|
      t.string     :string

      t.timestamps null: false
    end
  end
end
