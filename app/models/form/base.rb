module Form
  class Base < ActiveRecord::Base
    self.abstract_class = true
    self.table_name_prefix = 'form_'

    def self.virtual?
      false
    end

    def virtual?
      self.class.virtual?
    end

    include Form
  end
end
