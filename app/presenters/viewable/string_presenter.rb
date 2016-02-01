module Viewable
  class StringPresenter < ViewablePresenter
    def text
      h.strip_tags m.title
    end
  end
end
