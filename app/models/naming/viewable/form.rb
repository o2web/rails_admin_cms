module Naming
  module Viewable
    module Form
      class << self
        def names
          @_names ||= CMS.dir_names 'app/views/cms/forms'
        end

        def static_names
          @_static_names ||= CMS.rb_names 'app/models/form'
        end
      end
    end
  end
end
