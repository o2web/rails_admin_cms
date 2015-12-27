module CMS
  module ViewableHelper
    Viewable.names.each do |type|
      define_method "cms_#{type}" do |name, min = 1, max = nil| # FLOAT::INFINITY
        # TODO: N+1 optimization
        # default_scope { includes(:unique_key).where(unique_keys: { locale: I18n.locale }).order('unique_keys.position') }

        raise ArgumentError, "'min' can not be Float::INFINITY" if min == Float::INFINITY
        raise ArgumentError, "'name' must be a String" unless name.is_a? String

        presenter_list = (1..min).map do |position|
          find_or_create_presenter(type, name, position)
        end

        list_key = to_list_key(type, name)

        if max.nil?
          case min
          when 0
            raise ArgumentError, "if 'max' is not defined, 'min' must be greater than 0"
          when 1
            return presenter_list.first
          else
            return build_list_presenter(presenter_list, list_key, max)
          end
        elsif max < 1
          raise ArgumentError, "'max' must be greater than 0 or nil"
        end

        ((min + 1)..max).each do |position|
          if (presenter = find_presenter(type, name, position))
            presenter_list << presenter
          else
            break
          end
        end

        build_list_presenter(presenter_list, list_key, max)
      end
    end

    def link_to_switch_edit_mode
      next_mode = edit_mode? ? t('cms.show_mode') : t('cms.edit_mode')

      path = "#{request.path}?#{{ edit_mode: !edit_mode? }.to_query}"

      link_to next_mode, path
    end

    private

    def find_presenter(type, name, position)
      unique_key = to_unique_key(type, name, position)
      if (viewable = UniqueKey.find_viewable(unique_key))
        build_presenter(unique_key, viewable)
      end
    end

    def find_or_create_presenter(type, name, position)
      unique_key = to_unique_key(type, name, position)
      viewable = UniqueKey.find_or_create_viewable!(unique_key)
      build_presenter(unique_key, viewable)
    end

    def build_presenter(unique_key, viewable)
      presenter_class = "#{unique_key[:viewable_type]}Presenter".safe_constantize
      if presenter_class
        presenter_class.new(viewable, self)
      else
        ViewablePresenter.new(viewable, self)
      end
    end

    def build_list_presenter(viewables, list_key, max)
      list_presenter_class = "#{list_key[:viewable_type]}ListPresenter".safe_constantize
      if list_presenter_class
        list_presenter_class.new(viewables, self, list_key, max)
      else
        ViewableListPresenter.new(viewables, self, list_key, max)
      end
    end

    def to_unique_key(type, name, position)
      to_list_key(type, name).merge(position: position)
    end

    def to_list_key(type, name)
      {
        viewable_type: "Viewable::#{type.camelize}",
        view_path: @virtual_path,
        name: name,
        locale: locale,
      }
    end
  end
end
