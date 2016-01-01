module CMS
  module ViewableHelper
    Viewable::Block.names.each do |type|
      define_method "cms_#{type}" do |name = 'cms', min = 1, max = nil|
        cms_block("#{type}/#{name}", min, max)
      end
    end

    Viewable.names.each do |type|
      define_method "cms_#{type}" do |name = 'cms', min = 1, max = nil| # max = FLOAT::INFINITY
        if !name.is_a?(String) && !name.is_a?(Symbol)
          max, min = min, name
          name = 'cms'
        end

        validate_min_max! min, max

        name, return_page = validate_type_and_adjust_name_or_return_page! type, name

        return @page if return_page

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

      link_to next_mode, path
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

    def validate_min_max!(min, max)
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
    end

    def validate_type_and_adjust_name_or_return_page!(type, name)
      case type
      when 'page'
        if @page
          @page = Viewable::PagePresenter.new(@page, self)
          return_page = true
        end
      when 'block'
        if @block
          raise ArgumentError, "can not have cms_block(...) within block partials"
        end
        if @page
          name = @page.uuid_with(name)
        end
      else
        if @block
          name = @block.uuid_with(name)
        end
        if @page
          name = @page.uuid_with(name)
        end
      end
      [name, return_page]
    end

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
      cms_list_key(type, name).merge(position: position)
    end
  end
end
