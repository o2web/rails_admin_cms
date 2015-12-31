module Form
  class Object < ActiveType::Object
    def self.virtual?
      true
    end

    def virtual?
      self.class.virtual?
    end

    include Form
  end
end
