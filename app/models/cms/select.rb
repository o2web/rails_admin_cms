class CMS::Select < ActiveRecord::Base
  self.table_name = 'cms_selects'

  translates :label, :value
  include CMS::PagePartsBase
end
