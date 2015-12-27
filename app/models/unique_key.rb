class UniqueKey < ActiveRecord::Base
  include Admin::UniqueKey

  has_paper_trail if RailsAdminCMS::Config.with_paper_trail?

  belongs_to :viewable, polymorphic: true

  before_update ::Callbacks::UniqueKeyBeforeUpdate.new

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

  def list(locale)
    self.class.where(viewable_type: viewable_type, view_path: view_path, name: name).where(locale: locale)
  end

  def other_locales(position)
    self.class.where(viewable_type: viewable_type, view_path: view_path, name: name, position: position).where.not(locale: locale)
  end

  def with_unlocalized_buffered_position(new_position)
    with_localized_buffered_position(new_position) do

      # Heads-up! this where unlocalized buffered callbacks should be

      yield
    end
  end

  def with_localized_buffered_position(new_position)

    # Heads-up! this where localized buffered callbacks should be

    update_column(:position, 0)
    yield
    update_column(:position, new_position)
  end
end