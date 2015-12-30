module Viewable
  class Select < ActiveRecord::Base
    include Viewable
    include Admin::Viewable::Select
  end
end
