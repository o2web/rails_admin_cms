module Viewable
  class LinkListPresenter < ViewableListPresenter
    def wrapped_menu(name)
      h.content_tag :li do
        h.concat h.active_link_to(name, '#', active: active_menu?)
        h.concat(h.content_tag(:ul, sortable) do
          menu
        end)
      end
    end

    def menu
      each do |link|
        h.concat link.li_link_to_with_edit
      end
      h.concat(add_link) if h.cms_edit_mode?
    end

    def active_menu?
      !!active_link
    end

    def active_link
      @active_link ||= begin
        breadcrumbs
        @active_link
      end
    end

    def breadcrumbs
      @breadcrumbs ||= begin
        @active_link = nil
        take_while do |link|
          if link.active?
            @active_link = link
            false
          else
            true
          end
        end
      end
    end
  end
end
