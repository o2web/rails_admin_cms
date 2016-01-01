module Viewable
  class BlockPresenter < ViewablePresenter
    def render
      h.instance_variable_set :@block, m
      html = h.render m.partial_path
      h.instance_variable_set :@block, nil
      html
    end
  end
end
