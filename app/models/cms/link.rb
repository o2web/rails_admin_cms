class CMS::Link < ActiveRecord::Base
  self.table_name = 'cms_links'

  translates :title, :url, :page, :file
  include CMS::PagePartsBase
end
