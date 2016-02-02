module Viewable
  class StringPresenter < ViewablePresenter
    def text
      h.strip_tags m.string
    end
  end
end
