module Viewable
  class Link < ActiveRecord::Base
    include Viewable
    include Admin::Viewable::Link

    def page_enum
      Viewable::Page.all_urls + Viewable::Form.all_urls
    end
  end
end
