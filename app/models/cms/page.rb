class CMS::Page < ActiveRecord::Base
  self.table_name = 'cms_pages'
  translates :title, :url

  accepts_nested_attributes_for :translations, allow_destroy: true

  # rails_admin do
  #   configure :translations, :globalize_tabs
  #   nested do
  #     field :translations
  #   end
  #   field :controller
  #   field :action
  # end
end
