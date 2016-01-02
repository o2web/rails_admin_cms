module Viewable
  extend ActiveSupport::Concern

  included do
    self.table_name_prefix = 'viewable_'

    has_paper_trail if RailsAdminCMS::Config.with_paper_trail?

    has_one :unique_key, as: :viewable, dependent: :destroy

    delegate :view_path, :position, :locale, :list, :other_locales, to: :unique_key
    delegate :name, to: :unique_key, prefix: true

    after_destroy ::Callbacks::ViewableAfterDestroy.new
    before_update ::Callbacks::ViewableBeforeUpdate.new

    before_destroy :expire_cache
    after_update :expire_cache
    after_touch  :expire_cache

    scope :localized, -> { includes(:unique_key).where(unique_keys: { locale: I18n.locale }) }

    delegate :unlocalized_fields, :viewable_type, :dashed_name, :underscored_name, to: :class
  end

  class_methods do
    def has_unlocalized_fields(*fields)
      define_singleton_method :unlocalized_fields do
        fields
      end
    end

    def unlocalized_fields
      []
    end

    def viewable_type
      name
    end

    def dashed_name
      @_dashed_name ||= underscored_name.dasherize
    end

    def underscored_name
      @_underscored_name ||= name.underscore.gsub('/', '_')
    end
  end

  def short_type
    viewable_type.demodulize.underscore
  end

  def unique_key_hash(locale = nil)
    unique_key
      .slice(:viewable_type, :view_path, :name, :position)
      .merge(locale: locale || self.locale)
  end

  class << self
    def models
      @_models ||= names.map{ |name| "Viewable::#{name.camelize}" }
    end

    def names
      @_names ||= begin
        engine_viewables = Dir["#{RailsAdminCMS::Engine.root}/app/models/viewable/*.rb"].map { |name|
          File.basename(name).sub(/\.rb$/, '')
        }
        app_viewables = Dir["#{Rails.root}/app/models/viewable/*.rb"].map { |name|
          File.basename(name).sub(/\.rb$/, '')
        }
        engine_viewables + app_viewables
      end
    end
  end

  private

  def expire_cache
    ActionController::Base.new.expire_fragment /#{view_cache_key}/
  end

  def view_cache_key
    "#{locale}/#{view_path}"
  end
end
