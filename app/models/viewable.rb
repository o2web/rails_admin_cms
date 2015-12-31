module Viewable
  extend ActiveSupport::Concern

  # TODO fallback for translations

  included do
    self.table_name_prefix = 'viewable_'

    has_paper_trail if RailsAdminCMS::Config.with_paper_trail?

    has_one :unique_key, as: :viewable, dependent: :destroy

    delegate :view_path, :name, :position, :locale, :list, :other_locales, to: :unique_key

    after_destroy ::Callbacks::ViewableAfterDestroy.new
  end

  class_methods do
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

  def viewable_type
    self.class.viewable_type
  end

  def dashed_name
    self.class.dashed_name
  end

  def underscored_name
    self.class.underscored_name
  end

  class << self
    def pages
      @_pages ||= Dir["#{Rails.root}/app/views/cms/pages/*.html.*"].map do |name|
        File.basename(name).sub(/\.html\..+$/, '')
      end
    end

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
end
