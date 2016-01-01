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
            update_uuid_columns value
            other_locales.map(&:viewable).each do |viewable|
              viewable.__send__ :update_uuid_columns, value
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

      def update_uuid_columns(value)
        attributes = uuid_columns.map{ |key| [key, value] }.to_h
        update_columns attributes
      end

      def uuid_columns
        [:uuid]
      end
    end
  end
end
