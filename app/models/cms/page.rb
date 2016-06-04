class CMS::Page < ActiveRecord::Base
  self.table_name = 'cms_pages'

  translates :title, :url
  accepts_nested_attributes_for :translations, allow_destroy: true

  validates :url, uniqueness: true

  after_commit :reload_routes

  has_ancestry(
    cache_depth: true
  )

  has_many :texts
  has_many :strings

  def part_with_key(part, key)
    self.send(part.to_s.pluralize).with_key(key, self.id)
  end

  def current_url_for(locale)
    self.translations.with_locale(locale).first.url
  end

  rails_admin do
    configure :translations, :globalize_tabs
    create do
      field :translations
      field :controller
      field :action
    end

    edit do
      field :translations
    end

    nestable_tree(
      max_depth: 5,
      position_field: :position
    )
  end

  private

  def reload_routes
    Rails.application.routes_reloader.reload!
  end
end
