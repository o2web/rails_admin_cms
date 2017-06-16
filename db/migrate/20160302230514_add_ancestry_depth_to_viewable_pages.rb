class AddAncestryDepthToViewablePages < ActiveRecord::Migration
  def change
    add_column :viewable_pages, :ancestry_depth, :integer, default: 0
  end
end
