module Naming
  module Viewable
    class << self
      def names
        @_names ||= CMS.rb_all_names 'app/models/viewable'
      end
    end
  end
end
