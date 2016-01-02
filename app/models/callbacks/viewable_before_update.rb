module Callbacks
  class ViewableBeforeUpdate
    include Callback

    def call
      return unless m.unlocalized_fields.any?

      attributes = m.slice(*m.unlocalized_fields)

      m.other_locales.each do |viewable|
        viewable.update! attributes
      end
    end
  end
end
