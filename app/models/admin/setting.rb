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
          field :value, :string
          field :unit
        end
      end
    end
  end
end
