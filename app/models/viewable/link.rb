module Viewable
  class Link < ActiveRecord::Base
    include Viewable
    include Admin::Viewable::Link
  end
end
