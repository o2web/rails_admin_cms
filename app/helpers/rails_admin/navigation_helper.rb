module RailsAdmin
  module NavigationHelper
    CMSViewableEdit ||= /viewable~(\w+)\/(\d+)\/edit/
    CMSPageType     ||= /^cms\/pages\/(\w+)$/
    CMSPageFormType ||= /^cms\/forms\/(\w+)\/new$/
    CMSFormType     ||= /^cms\/forms\/(\w+)\/_form$/
    CMSPageUUID     ||= /^P\[(.+)\]/

    def admin_locale_selector
      selectors = I18n.available_locales.reject{ |l| l == locale }.map do |locale|
        if request.path =~ CMSViewableEdit
          viewable = extract_viewable($1, $2)
          unique_key = viewable.unique_key_hash(locale)
          other_id = UniqueKey.find_viewable(unique_key).id

          path = "#{dashboard_path}/viewable~#{$1}/#{other_id}/edit?locale=#{locale}"
        else
          path = "#{request.path}?#{ { locale: locale }.to_query }"
        end
        [locale, path]
      end

      selectors.map do |locale, path|
        content_tag :li do
          link_to t('cms.locale_selector.language', locale: locale), path
        end
      end.join.html_safe
    end

    def admin_back_home
      if request.path =~ CMSViewableEdit
        viewable = extract_viewable($1, $2)
        view_path, name, type = viewable.slice(:view_path, :unique_key_name, :viewable_type).values

        if type == 'Viewable::Page'
          path = viewable.url
        elsif name =~ CMSPageUUID
          path = Viewable::Page.find_by_uuid($1).url
        else
          case view_path
          when CMSPageType, CMSPageFormType, CMSFormType
            path = main_app.try "#{$1}_path"
          when /\/(\w+)\/index$/
            resources = $1
            if resources.singularize == resources
              path = main_app.try "#{resources}_index_path"
            else
              path = main_app.try "#{resources}_path"
            end
          when /\/\w+\/show$/
            scopes = view_path.split('/')
            scopes.pop
            resource = scopes.pop.singularize
            namespace = scopes.map(&:camelize).join('::')
            first_object = "#{namespace}::#{resource.camelize}".constantize.first

            if first_object
              path = main_app.try "#{resource}_path", first_object
            end
          end
        end
      end

      path ||= main_app.root_path

      content_tag :li do
        link_to t('admin.home.name'), path
      end
    end

    private

    def extract_viewable(type, id)
      @_viewable ||= "Viewable::#{type.camelize}".constantize.find(id)
    end
  end
end
