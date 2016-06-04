class CMS::Image < ActiveRecord::Base
  self.table_name = 'cms_images'

  translates :title, :image
  accepts_nested_attributes_for :translations, allow_destroy: true

  belongs_to :page
end
