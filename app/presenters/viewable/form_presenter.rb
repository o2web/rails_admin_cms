module Viewable
  class FormPresenter < ViewPresenter
    def initialize(model, context)
      super
      if m.not_static?
        h.cms_form_instance = m.fetch_row(h.cms_form_instance)
      end
    end
  end
end
