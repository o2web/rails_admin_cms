module Viewable
  class Page < ActiveRecord::Base
    include Viewable
    include Viewable::Field::UUID
    include Admin::Viewable::Page

    before_update :normalize_url
    after_commit :reload_routes

    scope :with_url, -> { where('url LIKE :url', url: '/%') }

    class << self
      def names
        @_names ||= Dir["#{Rails.root}/app/views/cms/pages/*.html.*"].map do |name|
          File.basename(name).sub(/\.html\..+$/, '')
        end
      end

      def urls
        localized.with_url.pluck(:url)
      end

      def all_urls
        paths = names.map do |name|
          Rails.application.routes.url_helpers.try "#{name}_path"
        end.compact
        (paths + urls).sort.uniq
      end

      def find_by_uuid(uuid)
        localized.find_by(uuid: uuid)
      end
    end

    def view_name
      @_view_name ||= view_path.split('/').last
    end

    def other_locale(locale)
      self.class.with_url.where(uuid: uuid).includes(:unique_key).where(unique_keys: { locale: locale }).first
    end

    private

    def uuid_columns
      super + [:url]
    end

    def normalize_url
      if url.present?
        segments = url.split('/').reject(&:blank?)
        segments.map{ |segment| segment.to_slug.normalize.to_s }
        self.url = segments.join('/').prepend('/')
      end
    end

    def reload_routes
      Rails.application.routes_reloader.reload!
    end
  end
end
