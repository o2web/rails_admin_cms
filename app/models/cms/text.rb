class CMS::Text < ActiveRecord::Base
  self.table_name = 'cms_texts'

  translates :title, :text
  include CMS::PagePartsBase

  rails_admin do
    configure :translations, :globalize_tabs
    visible false

    edit do
      field :translations
    end
  end

end
