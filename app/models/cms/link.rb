class CMS::Link < ActiveRecord::Base
  self.table_name = 'cms_links'

  translates :title, :url, :page, :file
  include CMS::PagePartsBase

  rails_admin do
    configure :translations, :globalize_tabs
    visible false

    edit do
      field :translations
      field :target_blank
      field :turbolink
    end
  end
end
