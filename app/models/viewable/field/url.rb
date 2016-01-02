module Viewable
  module Field
    module Url
      extend ActiveSupport::Concern

      included do
        before_update :normalize_url
        after_commit :reload_routes

        scope :with_url, -> { where('url LIKE :url', url: '/%') }
      end

      class_methods do
        def names
          raise NotImplementedError
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
      end

      private

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
end