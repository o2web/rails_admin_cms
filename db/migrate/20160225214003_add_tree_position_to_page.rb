class AddTreePositionToPage < ActiveRecord::Migration
  def change
    add_column :viewable_pages, :tree_position, :integer
  end
end
