class CMS::Text < ActiveRecord::Base
  self.table_name = 'cms_texts'
  translates :title, :text

  belongs_to :page
end
