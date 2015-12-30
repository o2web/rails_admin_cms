module Admin
  module Setting
    extend ActiveSupport::Concern

    included do
      rails_admin do
        navigation_label 'Configuration'

        edit do
          field :name do
            read_only true
          end
          field :value, :string do
            required true
          end
          field :unit do
            read_only true
          end
        end
      end
    end
  end
end