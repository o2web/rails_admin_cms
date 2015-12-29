module Viewable
  class Image < ActiveRecord::Base
    include Viewable
    include Admin::Viewable::Image
  end
end
