module Viewable
  class PagePresenter < ViewPresenter

    # build page tree without root
    def tree(css_class = 'tree')
      return if m.second_level_root.blank?
      h.content_tag :nav, class: css_class do
        h.concat render_tree_master_ul(m.second_level_root)
      end
    end

    # build page breadcrumbs from root
    def breadcrumbs(css_class = 'breadcrumbs')
      h.content_tag :nav, class: css_class do
        h.concat breadcrumbs_ul(breadcrumbs_list)
      end
    end

    private

    def breadcrumbs_list(page = m)
      while page.present?
        (pages ||= []).unshift(page)
        page = page.parent
      end
      pages
    end

    def breadcrumbs_ul(pages)
      h.content_tag :ul do
        pages.each do |page|
          h.concat(breadcrumbs_li(page))
        end
      end
    end

    def breadcrumbs_li(page)
      h.content_tag :li do
        h.concat (page == m || !page.show_link) ? h.content_tag(:span, page.title) : h.link_to(page.title, page.url)
      end
    end

    def render_tree_master_li(page)
      h.content_tag :li do
        h.concat h.content_tag(:span, page.title, data: {:'js-drawer-mobile' => true})
        page.children.order(:tree_position).each do |child|
          h.concat render_tree_ul(child)
        end if page.has_children? && page != m
      end
    end

    def render_tree_li(page)
      h.content_tag(:li, class: ('active' if page.subtree.include? m)) do
        h.concat h.link_to(page.title, page.url, class: ('active' if page == m))
        page.children.order(:tree_position).each do |child|
          h.concat render_tree_ul(child)
        end if page.has_children? && page != m && page.depth < m.depth
      end
    end

    def render_tree_master_ul(page)
      h.content_tag :ul do
        h.concat(render_tree_master_li(page))
      end
    end

    def render_tree_ul(page)
      h.content_tag :ul do
        h.concat(render_tree_li(page))
      end
    end
  end
end
