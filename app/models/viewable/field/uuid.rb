module Viewable
  module Field
    module UUID
      extend ActiveSupport::Concern

      included do
        after_destroy :destroy_viewables
      end

      class_methods do
        def prefix
          @_prefix ||= model_name.human[0]
        end
      end

      def uuid
        value = read_attribute(:uuid)
        if value.blank?
          value = SecureRandom.uuid
          transaction do
            update_column(:uuid, value)
            other_locales.map(&:viewable).each do |viewable|
              viewable.update_column(:uuid, value)
            end
          end
        end
        value
      end

      def uuid_with(name)
        "#{self.class.prefix}[#{uuid}]/#{name}"
      end

      private

      def destroy_viewables
        UniqueKey.where('name LIKE :uuid', uuid: "%#{self.class.prefix}[#{uuid}]%").destroy_all
      end
    end
  end
end
