module Form
  module Static
    class Base < ActiveRecord::Base
      include Form
      include Static

      self.table_name_prefix = 'form_static_'
    end
  end
end
