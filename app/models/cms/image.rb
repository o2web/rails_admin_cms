class CMS::Image < ActiveRecord::Base
  self.table_name = 'cms_images'

  translates :title, :image
  include CMS::PagePartsBase

  rails_admin do
    configure :translations, :globalize_tabs
    visible false

    edit do
      field :translations
    end
  end
end
