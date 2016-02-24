module Admin
  module UniqueKey
    extend ActiveSupport::Concern

    included do
      rails_admin do
        visible false

        object_label_method do
          :id
        end

        edit do
          field :view_path
        end
      end
    end
  end
end
