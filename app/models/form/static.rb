module Form
  module Static
    extend ActiveSupport::Concern

    included do
      self.abstract_class = true
    end

    def with_email?
      false
    end

    def form_name
      model_name.element
    end

    def js_form_selector
      "#new_form_#{form_name}"
    end
  end
end