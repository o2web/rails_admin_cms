module Viewable
  class Block < ActiveRecord::Base
    include Viewable
    include Viewable::Field::UUID
    include Admin::Viewable::Block

    def partial_path
      @_partial_path ||= "cms/blocks/#{unique_key_name.partition('/').first}"
    end

    class << self
      def names
        @_names ||= begin
          Dir["#{Rails.root}/app/views/cms/blocks/*.html.*"].map do |name|
            name = File.basename(name).sub(/\.html\..+$/, '').sub(/^_/, '')
            if name.in?(Viewable.names + %w[ cache ])
              raise ArgumentError, "'cms/blocks/_#{name}.html' partial should be called otherwise, '#{name}' taken"
            end
            name
          end
        end
      end
    end
  end
end
