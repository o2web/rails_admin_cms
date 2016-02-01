class CreateViewableString < ActiveRecord::Migration
  def change
    create_table :viewable_strings do |t|
        t.string     :title

        t.timestamps null: false
    end
  end
end
