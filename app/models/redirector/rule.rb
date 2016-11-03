module Redirector
  class Rule < ActiveRecord::Base
    include Admin::Redirector::Rule
    self.table_name = "redirect_rules"
  end
end