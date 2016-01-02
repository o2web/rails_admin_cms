module Viewable
  class BlockPresenter < ViewablePresenter
    def render
      h.instance_variable_set :@cms_view_partial, m
      html = h.render m.partial_path
      h.instance_variable_set :@cms_view_partial, nil
      html
    end
  end
end
