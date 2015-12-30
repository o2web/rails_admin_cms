module Viewable
  class SelectListPresenter < ViewableListPresenter
    def options
      map(&:option)
    end
  end
end
