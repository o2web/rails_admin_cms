class CMS::Link < ActiveRecord::Base
  self.table_name = 'cms_links'

  translates :title, :url, :page, :file
  accepts_nested_attributes_for :translations, allow_destroy: true

  belongs_to :page
end
