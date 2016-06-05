module CMS::PagePartsBase
  extend ActiveSupport::Concern

  included do
    accepts_nested_attributes_for :translations, allow_destroy: true

    belongs_to :page

    class << self
      def with_key(key, page_id)
        self.where(key: key).try(:first) || create_with_key(key, page_id)
      end

      def all_with_key(key, page_id, min = nil)
        all = self.where(key: key)
        return all if all.any?
        create_with_key(key, page_id, min)
      end

      def global_with_key(key)
        self.where(key: key, page_id: nil).try(:first) || create_global_with_key(key)
      end

      def all_globals_with_key(key, min)
        all = self.where(key: key, page_id: nil)
        return all if all.any?
        create_global_with_key(key, min)
      end

      def add_with_key(key, page_id, position)
        return self.create(key: key, page_id: page_id, position: position)
      end

      private

      def create_with_key(key, page_id, min = nil)
        return self.create(key: key, page_id: page_id) if min.nil?
        list = []
        min.times do |i|
          list.push self.create(key: key, page_id: page_id, position: i+1)
        end
        list
      end

      def create_global_with_key(key, min)
        return self.create(key: key, page_id: nil) if min.nil?
        list = []
        min.times do |i|
          list.push self.create(key: key, page_id: nil, position: i+1)
        end
        list
      end
    end
  end
end
