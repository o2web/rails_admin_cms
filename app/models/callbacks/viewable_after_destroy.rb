module Callbacks
  class ViewableAfterDestroy
    include Callback

    def init
      @range = (m.position + 1)..Float::INFINITY
    end

    def call
      update_unlocalized_list
      m.other_locales(m.position).map(&:viewable).each do |viewable|
        viewable.destroy!
        update_localized_list(viewable.locale)
      end
    end

    private

    def update_unlocalized_list
      # Heads-up! this where unlocalized delete files after destroy callbacks should be

      update_localized_list(m.locale) do |viewable, position_was, position|
        # Heads-up! this where unlocalized after destroy callbacks should be

      end
    end

    def update_localized_list(locale)
      # Heads-up! this where localized delete files after destroy callbacks should be

      each_position(locale) do |viewable, position_was, position|
        viewable.unique_key.update_column(:position, position)
        # Heads-up! this where localized after destroy callbacks should be

        yield viewable, position_was, position if block_given?
      end
    end

    def each_position(locale)
      query = m.list(locale).where(position: @range).order(:position)
      query.map(&:viewable).each.with_index do |unique_key, i|
        position_was = unique_key.position
        position = m.position + i

        yield unique_key, position_was, position
      end
    end
  end
end
