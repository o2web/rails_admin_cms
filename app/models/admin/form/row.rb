module Admin
  module Form
    module Row
      extend ActiveSupport::Concern

      included do
        rails_admin do
          object_label_method do
            :id
          end

          exclude_fields :fields, :viewable, :structure

          list do
            configure :id do
              sort_reverse false
            end

            scopes ::Form::Structure.scopes
          end
        end
      end
    end
  end
end
