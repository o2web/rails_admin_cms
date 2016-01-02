module Form
  module Static
    class Object < ActiveType::Object
      include Form
      include Static

      def self.virtual?
        true
      end
    end
  end
end
