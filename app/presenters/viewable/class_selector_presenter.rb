module Viewable
  class ClassSelectorPresenter < ViewablePresenter
    def classes
      "#{m.main_class} #{m.extra_classes}"
    end
  end
end
