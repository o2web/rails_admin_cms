class CMS::Text < ActiveRecord::Base
  self.table_name = 'cms_texts'

  translates :title, :text
  accepts_nested_attributes_for :translations, allow_destroy: true

  belongs_to :page

  class << self
    def with_key(key, page_id)
      self.where(key: key).try(:first) || create_with_key(key, page_id)
    end

    private

    def create_with_key(key, page_id)
      self.create(key: key, page_id: page_id)
    end
  end
end
