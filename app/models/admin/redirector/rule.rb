module Admin
  module Redirector
    module Rule
      extend ActiveSupport::Concern

      included do
        rails_admin do
          list do
            field :id
            field :active
            field :source
            field :destination
          end

          edit do
            field :active
            field :source_is_regex
            field :source_is_case_sensitive
            field :source
            field :destination
          end
        end
      end
    end
  end
end