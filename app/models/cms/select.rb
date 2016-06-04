class CMS::Select < ActiveRecord::Base
  self.table_name = 'cms_selects'

  translates :label, :value
  accepts_nested_attributes_for :translations, allow_destroy: true

  belongs_to :page
end
