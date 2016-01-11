module Naming
  module Form
    class << self
      def models
        @_models ||= Naming::Form.structure_models + Naming::Form.static_models + %w[
          Form::Row
        ]
      end

      def static_models
        @_static_models ||= Naming::Viewable::Form.static_names.map{ |name| "Form::#{name.camelize}" }
      end

      def structure_models
        %w[
          Form::Structure
          Form::Field
          Form::Email
        ]
      end
    end
  end
end
