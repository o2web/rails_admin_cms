class AddAncestryToViewablePage < ActiveRecord::Migration
  def change
    add_column :viewable_pages, :ancestry, :string
  end
end
