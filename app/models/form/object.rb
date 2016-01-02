module Form
  class Object < ActiveType::Object
    include Form

    def self.virtual?
      true
    end
  end
end
