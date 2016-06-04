class CMS::Image < ActiveRecord::Base
  self.table_name = 'cms_images'

  translates :title, :image
  include CMS::PagePartsBase
end
