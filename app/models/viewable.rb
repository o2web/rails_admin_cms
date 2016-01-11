module Viewable
  extend ActiveSupport::Concern

  included do
    self.table_name_prefix = 'viewable_'

    has_paper_trail

    has_one :unique_key, as: :viewable, dependent: :destroy

    delegate :view_path, :position, :locale, to: :unique_key
    delegate :name, to: :unique_key, prefix: true

    after_destroy ::Callbacks::ViewableAfterDestroy.new
    before_update ::Callbacks::ViewableBeforeUpdate.new

    before_destroy :expire_cache
    after_update :expire_cache
    after_touch  :expire_cache

    scope :localized, -> { includes(:unique_key).where(unique_keys: { locale: I18n.locale }) }
    scope :other_locale, ->(locale) { includes(:unique_key).where(unique_keys: { locale: locale }) }

    delegate :has_unlocalized_fields?, :unlocalized_fields, :viewable_type, to: :class
  end

  class_methods do
    def has_unlocalized_fields(*fields)
      define_singleton_method :unlocalized_fields do
        fields
      end
    end

    def has_unlocalized_fields?
      unlocalized_fields.any?
    end

    def unlocalized_fields
      []
    end

    def viewable_type
      name
    end
  end

  def list(locale = nil)
    self.class.includes(:unique_key)
      .where(unique_keys: { viewable_type: viewable_type, view_path: view_path, name: unique_key_name })
      .where(unique_keys: { locale: locale || self.locale })
  end

  def other_locales(position = nil)
    self.class.includes(:unique_key)
      .where(unique_keys: { viewable_type: viewable_type, view_path: view_path, name: unique_key_name })
      .where(unique_keys: { position: position || self.position })
      .where.not(unique_keys: { locale: locale })
  end

  def unique_key_hash(locale = nil)
    unique_key
      .slice(:viewable_type, :view_path, :name, :position)
      .merge(locale: locale || self.locale)
  end

  private

  def expire_cache
    ActionController::Base.new.expire_fragment /#{view_path}/
  end
end
