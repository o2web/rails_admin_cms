module Form
  class Row::AsHeader < Row
    include Admin::Form::Row::AsHeader

    def with_email?
      false
    end
  end
end
