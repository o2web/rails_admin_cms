module Form
  class Object < ActiveType::Object
    self.abstract_class = true

    def self.virtual?
      true
    end

    def virtual?
      self.class.virtual?
    end

    include Form
  end
end
