class ChangeViewableStringColumnName < ActiveRecord::Migration
  def change
    rename_column :viewable_strings, :title, :string
  end
end
