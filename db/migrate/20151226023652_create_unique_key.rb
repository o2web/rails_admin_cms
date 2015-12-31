class CreateUniqueKey < ActiveRecord::Migration
  def change
    create_table :unique_keys do |t|
      t.references  :viewable, polymorphic: true, index: true
      t.text        :view_path, null: false
      t.text        :name,      null: false
      t.integer     :position,  null: false
      t.string      :locale,    null: false

      t.timestamps null: false
    end

    add_index(
      :unique_keys,
      [ :viewable_type, :view_path, :name, :position, :locale ],
      { unique: true, name: 'index_unique_keys_on_unique_key' }
    )
  end
end
