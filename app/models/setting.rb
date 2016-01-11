class Setting < ActiveRecord::Base
  include Admin::Setting

  has_paper_trail

  cattr_accessor :cache
  self.cache = Rails.cache

  after_commit :expire_cache

  class << self
    def []=(name, value)
      write(name, value)

      find_or_create_by!(name: name) do |setting|
        setting.value = value
      end

      value
    end

    def [](name)
      if has_key? name
        return read(name)
      end

      if (setting = find_by(name: name))
        value = setting.value
      else
        value = yield # default value passed as block
      end

      write(name, value)

      value
    end

    def has_key?(name)
      cache.exist? cache_key(name)
    end

    def expire(name)
      cache.delete cache_key(name)
    end

    def apply_all(settings = {})
      settings.each do |name, value|
        find_or_create_by!(name: name) do |setting|
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
        find_by(name: name).try(:destroy!)
        expire(name)
      end
    end

    private

    def read(name)
      cache.read cache_key(name)
    end

    def write(name, value)
      cache.write cache_key(name), value
    end

    def cache_key(name)
      "setting/#{name}"
    end
  end

  private

  def expire_cache
    self.class.expire(name)
  end
end
