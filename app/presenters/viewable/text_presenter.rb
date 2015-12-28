module Viewable
  class TextPresenter < ViewablePresenter
    def html
      m.html.try(:html_safe)
    end

    def text
      h.strip_tags m.html
    end
  end
end
