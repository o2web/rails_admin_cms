module CMS
  module ViewableHelper
    def self.define_cms_view_helper(type)
      define_method "cms_view_#{type}" do |name = 'cms', min = 1, max = nil|
        name, min, max = adjust_arguments(name, min, max)

        public_send("cms_#{type}", @cms_view.uuid_with(name), min, max)
      end
    end

    ::Naming::Viewable::Block.names.each do |type|
      define_cms_view_helper(type)

      define_method "cms_#{type}" do |name = 'cms', min = 1, max = nil|
        name, min, max = adjust_arguments(name, min, max)

        cms_block("#{type}/#{name}", min, max)
      end
    end

    ::Naming::Viewable.names.each do |type|
      define_cms_view_helper(type)

      # access a Viewable within the current context
      # name(optional):
      # min (optional): defines how many viewables are created by default
      # max (optional): defines the limit of viewables that could added (must be greater than min)
      # * if min = 1, then a single ViewablePresenter is returned, otherwise, a ViewablePresenterList is returned
      define_method "cms_#{type}" do |name = 'cms', min = 1, max = nil| # max = FLOAT::INFINITY
        name, min, max = adjust_arguments(name, min, max)

        validate_arguments! type, min, max

        name, presenter = adjust_name_or_build_view_presenter type, name

        return presenter if presenter

        presenter_list = (1..min).map do |position|
          find_or_create_presenter(type, name, position)
        end

        list_key = cms_list_key(type, name)

        if max.nil?
          if min == 1
            return presenter_list.first
          else
            return build_list_presenter(presenter_list, list_key, max)
          end
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

    def cms_link_to_edit_mode
      next_mode = cms_edit_mode? ? t('cms.show_mode') : t('cms.edit_mode')

      path = "#{request.path}?#{{ edit_mode: !cms_edit_mode? }.to_query}"

      link_to next_mode, path, 'data-no-turbolink': :true
    end

    def cms_list_key(type, name)
      {
        viewable_type: "Viewable::#{type.camelize}",
        view_path: @virtual_path,
        name: name,
        locale: locale,
      }
    end

    private

    def adjust_arguments(name, min, max)
      if !name.is_a?(String) && !name.is_a?(Symbol)
        max, min = min, name
        name = 'cms'
      end
      [name, min, max]
    end

    def validate_arguments!(type, min, max)
      if min == Float::INFINITY
        raise ArgumentError, "'min' can not be Float::INFINITY"
      end
      if max.nil?
        if min == 0
          raise ArgumentError, "if 'max' is not defined, 'min' must be greater than 0"
        end
      elsif max < 1
        raise ArgumentError, "'max' must be greater than 0 or nil"
      end
      if type == 'block' && @cms_view_partial
        raise ArgumentError, "can not have cms_block(...) within block partials"
      end
    end

    def adjust_name_or_build_view_presenter(type, name)
      case type
      when 'page'
        if @cms_view
          presenter = ::Viewable::PagePresenter.new(@cms_view, self)
        end
      when 'form'
        if @cms_view
          presenter = ::Viewable::FormPresenter.new(@cms_view, self)
        end
      else
        if @cms_view_partial
          name = @cms_view_partial.uuid_with(name)
        end
      end
      [name, presenter]
    end

    def find_presenter(type, name, position)
      unique_key = to_unique_key(type, name, position)
      if (viewable = ::UniqueKey.find_viewable(unique_key))
        build_presenter(unique_key, viewable)
      end
    end

    def find_or_create_presenter(type, name, position)
      unique_key = to_unique_key(type, name, position)
      viewable = ::UniqueKey.find_or_create_viewable!(unique_key)
      build_presenter(unique_key, viewable)
    end

    def build_presenter(unique_key, viewable)
      presenter_class = "::#{unique_key[:viewable_type]}Presenter".safe_constantize
      if presenter_class
        presenter_class.new(viewable, self)
      else
        ::ViewablePresenter.new(viewable, self)
      end
    end

    def build_list_presenter(viewables, list_key, max)
      list_presenter_class = "::#{list_key[:viewable_type]}ListPresenter".safe_constantize
      if list_presenter_class
        list_presenter_class.new(viewables, self, list_key, max)
      else
        ::ViewableListPresenter.new(viewables, self, list_key, max)
      end
    end

    def to_unique_key(type, name, position)
      cms_list_key(type, name).merge(position: position)
    end
  end
end
