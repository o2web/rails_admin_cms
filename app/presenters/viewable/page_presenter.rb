module Viewable
  class PagePresenter < ViewPresenter

    # build page tree from specified root_depth, default second level root
    def tree(root_depth = 1, css_class = 'tree')
      return if m.parent_at_depth(root_depth).nil?
      h.content_tag :nav, class: css_class do
        h.concat render_tree_master_ul(m.parent_at_depth(root_depth))
      end
    end

    # build page breadcrumbs from specified root_depth, default root
    def breadcrumbs(root_depth = 0, css_class = 'breadcrumbs')
      return if m.parent_at_depth(root_depth).nil?
      h.content_tag :nav, class: css_class do
        h.concat breadcrumbs_ul(breadcrumbs_list(root_depth))
      end
    end

    private

    def breadcrumbs_list(root_depth = 0, page = m)
      while page.present? && page.depth >= root_depth
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
        h.concat (!page.show_link) ? h.content_tag(:span, page.title) : h.link_to(page.title, page.url)
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
        end if page.has_children? && (page.depth < m.depth || m == page)
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
