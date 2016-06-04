class CMS::Text < ActiveRecord::Base
  self.table_name = 'cms_texts'
  translates :title, :text

  belongs_to :page

  scope :with_key, -> (key) { where(key: key).first }
end
