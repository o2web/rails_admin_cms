module CMS
  module CacheHelper
    def cms_cache(name = nil)
      cache_unless no_cache, cache_key(name) do
        yield
      end
    end

    private

    def no_cache
      cms_edit_mode? || forms_create?
    end

    def forms_create?
      controller_name == 'forms' && action_name == 'create'
    end

    def cache_key(name)
      key = [locale, @virtual_path]
      key << name if name
      key
    end
  end
end
