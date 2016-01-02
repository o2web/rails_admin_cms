module Form
  class Base < ActiveRecord::Base
    include Form

    self.table_name_prefix = 'form_'
  end
end
