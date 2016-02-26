class UniqueKey < ActiveRecord::Base
  include Admin::UniqueKey

  has_paper_trail

  belongs_to :viewable, polymorphic: true

  before_validation :set_new_position if :view_path_changed?
  before_update ::Callbacks::UniqueKeyBeforeUpdate.new unless :view_path_changed?
  after_update :change_other_locales_record if :view_path_changed?

  with_options on: :update do
    validates :position, numericality: { greater_than: 0 }
    validates :position, numericality: { less_than_or_equal_to: :list_count }
  end

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
      viewable.try(:uuid) # forces uuid creation
      viewable
    end
  end

  def set_new_position
    self.position = list_count if self.view_path_changed?
  end

  def list_count
    return self.list.count + 1 if self.view_path_changed?
    self.list.count
  end

  def list(locale = nil)
    self.class
      .where(viewable_type: viewable_type, view_path: view_path, name: name)
      .where(locale: locale || self.locale)
  end

  def change_other_locales_record
    unique_keys = self.class
                    .where(viewable_type: viewable_type_was, view_path: view_path_was, name: name_was)
                    .where(position: position_was || self.position_was)
                    .where.not(locale: locale_was || self.locale_was)
    unique_keys.each do |unique_key|
      unique_key.update_columns(position: self.position, view_path: self.view_path)
    end

    I18n.available_locales.each do |locale|
      unique_keys = self.class
        .where(viewable_type: viewable_type_was, view_path: view_path_was, name: name_was)
        .where(locale: locale)
        .order(:position)
      unique_keys.each.with_index(1) do |unique_key, index|
        if unique_key.position != index
          unique_key.update_columns(position: index)
        end
      end
    end
  end

  def other_locales(position = nil)
    self.class
      .where(viewable_type: viewable_type, view_path: view_path, name: name)
      .where(position: position || self.position)
      .where.not(locale: locale)
  end

  def other_locale(locale = nil)
    self.class
      .where(viewable_type: viewable_type, view_path: view_path, name: name)
      .where(position: self.position)
      .where(locale: locale)
  end

  def with_buffered_position(new_position)
    update_column(:position, 0)
    yield
    update_column(:position, new_position)
    viewable.touch
  end
end
