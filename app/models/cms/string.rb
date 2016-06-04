class CMS::String < ActiveRecord::Base
  self.table_name = 'cms_strings'

  translates :string
  include CMS::PagePartsBase

  rails_admin do
    configure :translations, :globalize_tabs
    visible false

    edit do
      field :translations
    end
  end
end
