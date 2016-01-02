module Viewable
  module Field
    module UUID
      extend ActiveSupport::Concern

      included do
        after_destroy :destroy_other_uuids
      end

      class_methods do
        def uuid_with_prefix
          @_uuid_with_prefix ||= model_name.human[0]
        end

        def find_by_uuid(uuid)
          localized.find_by(uuid: uuid)
        end
      end

      def uuid
        value = read_attribute(:uuid)
        if value.blank?
          value = SecureRandom.uuid
          transaction do
            update_uuid_columns value
            other_locales.each do |viewable|
              viewable.__send__ :update_uuid_columns, value
            end
          end
        end
        value
      end

      def uuid_with(name)
        "#{self.class.uuid_with_prefix}[#{uuid}]/#{name}"
      end

      def other_uuid(locale)
        self.class.where(uuid: uuid).includes(:unique_key).where(unique_keys: { locale: locale }).first
      end

      private

      def destroy_other_uuids
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
