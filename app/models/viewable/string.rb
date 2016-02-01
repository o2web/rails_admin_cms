module Viewable
  class String < ActiveRecord::Base
    include Viewable
    include Admin::Viewable::String
  end
end
