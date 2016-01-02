module Callbacks
  class ViewableBeforeUpdate
    include Callback

    def call
      return unless m.has_unlocalized_fields?

      attributes = m.slice(*m.unlocalized_fields)

      m.other_locales.map(&:viewable).each do |viewable|
        viewable.update! attributes
      end
    end
  end
end
