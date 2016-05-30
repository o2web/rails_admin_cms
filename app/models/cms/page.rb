class CMS::Page < ActiveRecord::Base
  self.table_name = 'cms_page'
  translates :title, :url

  accepts_nested_attributes_for :translations, allow_destroy: true
end
