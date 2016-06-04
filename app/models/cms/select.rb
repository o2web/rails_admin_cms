class CMS::Select < ActiveRecord::Base
  self.table_name = 'cms_selects'

  translates :label, :value
  include CMS::PagePartsBase

  rails_admin do
    configure :translations, :globalize_tabs
    visible false

    edit do
      field :translations
    end
  end
end
