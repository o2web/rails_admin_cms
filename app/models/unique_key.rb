class UniqueKey < ActiveRecord::Base
  include Admin::UniqueKey

  has_paper_trail if RailsAdminCMS::Config.with_paper_trail?

  belongs_to :viewable, polymorphic: true

  before_update ::Callbacks::UniqueKeyBeforeUpdate.new

  validates :position, numericality: { less_than_or_equal_to: :list_count }, on: :update

  delegate :count, to: :list, prefix: true

  class << self
    def find_viewable(unique_key)
      (unique_key = find_by(unique_key)) ? unique_key.viewable : nil
    end

    def find_or_create_viewable!(unique_key)
      unless (viewable = find_viewable(unique_key))
        viewable = create_localized_viewable!(unique_key)
      end
      viewable
    end

    def create_localized_viewable!(unique_key)
      viewable = nil
      I18n.available_locales.each do |locale|
        attributes = unique_key.merge(locale: locale, viewable: unique_key[:viewable_type].constantize.new)
        new_record = find_or_create_by! attributes
        if I18n.locale == locale
          viewable = new_record.viewable
        end
      end
      viewable
    end
  end

  def list(locale = nil)
    self.class
      .where(viewable_type: viewable_type, view_path: view_path, name: name)
      .where(locale: locale || self.locale)
  end

  def other_locales(position = nil)
    self.class
      .where(viewable_type: viewable_type, view_path: view_path, name: name)
      .where(position: position || self.position)
      .where.not(locale: locale)
  end

  def with_buffered_position(new_position)
    update_column(:position, 0)
    yield
    update_column(:position, new_position)
    viewable.touch
  end
end
