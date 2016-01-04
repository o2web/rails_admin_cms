module Callbacks
  module Form
    class FieldBeforeUpdate
      include Restrictor

      def call
        if m.position_was < m.position
          # move list range downward
          range = (m.position_was + 1)..m.position
          reverse = false
        else
          # move list range upward
          range = m.position..(m.position_was - 1)
          reverse = true
        end
        query = m.fields.where(position: range)
        if reverse
          query = query.reverse_order
        end
        query.each.with_index do |field, i|
          position = reverse ? m.position_was - i : m.position_was + i

          field.update_column(:position, position)
        end
        m.update_header
      end
    end
  end
end
