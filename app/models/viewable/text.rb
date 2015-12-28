module Viewable
  class Text < ActiveRecord::Base
    include Viewable
    include Admin::Viewable::Text
  end
end
