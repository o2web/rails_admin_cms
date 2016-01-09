module Naming
  module Viewable
    class << self
      def names
        @_names ||= CMS.rb_all_names 'app/models/viewable'
      end

      def models
        @_models ||= Naming::Viewable.names.map{ |name| "Viewable::#{name.camelize}" }
      end
    end
  end
end
