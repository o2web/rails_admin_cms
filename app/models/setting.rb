class Setting < ActiveRecord::Base
  include Admin::Setting

  has_paper_trail if RailsAdminCMS::Config.with_paper_trail?

  cattr_accessor :cache
  @@cache = Rails.cache

  class << self
    def []=(name, value)
      cache.write(name, value)
      setting = where(name: name).first_or_initialize
      setting.value = value
      setting.save
    end

    def [](name)
      unless (value = cache.read(name)).nil?
        return value
      end

      if (setting = find_by(name: name))
        value = setting.value
      else
        value = yield # default value passed as block
      end

      cache.write(name, value)

      value.presence
    end

    def has_key?(name)
      cache.exist? name
    end

    def expire(name)
      cache.delete(name)
    end

    def apply_all(settings = {})
      settings.each do |name, value|
        find_or_create_by!(name: name.to_s) do |setting|
          if value.is_a? Array
            setting.value, setting.unit = value
          else
            setting.value = value
          end
        end
      end
    end

    def remove_all(*settings)
      settings.each do |name|
        find_by(name: name.to_s).try(:destroy!)
        expire(name)
      end
    end
  end
end
