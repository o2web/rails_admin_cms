module Callbacks
  class ViewableAfterDestroy
    include Callback

    def init
      @range = (m.position + 1)..Float::INFINITY
    end

    def call
      update_list
      m.other_locales.each do |viewable|
        viewable.destroy!
        update_list(viewable.locale)
      end
    end

    private

    def update_list(locale = nil)
      query = m.list(locale).where(unique_keys: { position: @range }).order('unique_keys.position')

      query.each.with_index(m.position) do |viewable, position|
        viewable.unique_key.update_column(:position, position)
      end
    end
  end
end
