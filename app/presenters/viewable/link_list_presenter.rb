module Viewable
  class LinkListPresenter < ViewableListPresenter
    def wrapped_menu(name)
      h.content_tag :li do
        h.concat h.active_link_to(name, '#', active: active_menu_regex)
        h.concat(h.content_tag(:ul, sortable) do
          menu
        end)
      end
    end

    def menu
      each do |link|
        h.concat link.li_active_link_to_with_edit
      end
      h.concat(add_link) if h.cms_edit_mode?
    end

    private

    def active_menu_regex
      conditions = map(&:url).reject{ |url| url == '#' || url[/^http/] }.join('|')
      /^(#{conditions})/
    end
  end
end
