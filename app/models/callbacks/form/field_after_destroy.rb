module Callbacks
  module Form
    class FieldAfterDestroy
      include Callback

      def call
        range = (m.position + 1)..Float::INFINITY
        query = m.fields.where(position: range)
        query.each.with_index(m.position) do |field, position|
          field.update_column(:position, position)
        end
        m.update_header
      end
    end
  end
end
