module Viewable
  class FormPresenter < ViewPresenter
    def initialize(model, context)
      super
      if m.not_static?
        if m.structure.nil?
          m.create_structure!(viewable: m)
        end
        attributes = h.cms_form_instance.attributes
        attributes['structure_id'] = m.structure_id
        h.cms_form_instance = m.rows.build(attributes)
      end
    end
  end
end
