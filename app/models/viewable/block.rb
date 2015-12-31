module Viewable
  class Block < ActiveRecord::Base
    include Viewable
    include Admin::Viewable::Block

    after_destroy :destroy_viewables

    def partial
      @_partial ||= "cms/blocks/#{name.partition('/').first}"
    end

    def uuid
      value = read_attribute(:uuid)
      if value.blank?
        value = SecureRandom.uuid
        transaction do
          update_column(:uuid, value)
          other_locales.map(&:viewable).each do |viewable|
            viewable.update_column(:uuid, value)
          end
        end
      end
      value
    end

    def uuid_with(name)
      "B[#{uuid}]/#{name}"
    end

    class << self
      def names
        @_names ||= begin
          Dir["#{Rails.root}/app/views/cms/blocks/*.html.*"].map do |name|
            name = File.basename(name).sub(/\.html\..+$/, '').sub(/^_/, '')
            if name.in? Viewable.names
              raise ArgumentError, "'cms/blocks/_#{name}.html' partial should be called otherwise, '#{name}' taken"
            end
            name
          end
        end
      end
    end

    private

    def destroy_viewables
      UniqueKey.where('name LIKE :uuid', uuid: "%B[#{uuid}]%").destroy_all
    end
  end
end
