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
      m.with_unlocalized_buffered_position(@position) do
        update_unlocalized_list
        m.other_locales(@position_was).each do |unique_key|
          unique_key.with_localized_buffered_position(@position) do
            update_localized_list(unique_key.locale)
          end
        end
      end
    end

    private

    def update_unlocalized_list
      update_localized_list(m.locale) do |unique_key, position_was, position|
        # Heads-up! this where unlocalized before save callbacks should be

      end
    end

    def update_localized_list(locale)
      each_position(locale) do |unique_key, position_was, position|
        unique_key.update_column(:position, position)
        # Heads-up! this where localized before save callbacks should be

        yield unique_key, position_was, position if block_given?
      end
    end

    def each_position(locale)
      query = m.list(locale).where(position: @range).order(:position)
      if @reverse
        query = query.reverse_order
      end
      query.each.with_index do |unique_key, i|
        position_was = unique_key.position
        position = @reverse ? m.position_was - i : m.position_was + i

        yield unique_key, position_was, position
      end
    end
  end
end
