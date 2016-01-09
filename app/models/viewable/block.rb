module Viewable
  class Block < ActiveRecord::Base
    include Viewable
    include Field::UUID
    include Admin::Viewable::Block

    def partial_path
      @_partial_path ||= "cms/blocks/#{partial_name}"
    end

    def partial_name
      @_partial_name ||= unique_key_name.partition('/').first
    end
  end
end
