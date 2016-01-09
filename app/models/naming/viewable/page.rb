module Naming
  module Viewable
    module Page
      class << self
        def names
          @_names ||= CMS.html_names 'app/views/cms/pages'
        end
      end
    end
  end
end
