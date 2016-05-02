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
      key = [@virtual_path, locale]
      key << @cms_view.uuid if @cms_view
      key << @show_page.class if @show_page
      key << @show_page.id if @show_page
      key << name if name
      key
    end
  end
end
