module Callbacks
  class UniqueKeyBeforeUpdate
    include Callback

    def init
      # keep position and position_was, because buffered_position rewrites them
      @position, @position_was = m.position, m.position_was
      if @position_was < @position
        # move list range downward
        @range = (@position_was + 1)..@position
        @reverse = false
      else
        # move list range upward
        @range = @position..(@position_was - 1)
        @reverse = true
      end
    end

    def call
      m.with_buffered_position(@position) do
        update_list
        m.other_locales(@position_was).each do |unique_key|
          unique_key.with_buffered_position(@position) do
            update_list(unique_key.locale)
          end
        end
      end
    end

    private

    def update_list(locale = nil)
      query = m.list(locale).where(position: @range).order(:position)
      if @reverse
        query = query.reverse_order
      end

      query.each.with_index do |unique_key, i|
        position = @reverse ? m.position_was - i : m.position_was + i

        unique_key.update_column(:position, position)
      end
    end
  end
end
