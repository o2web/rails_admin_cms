class CMS::PagePresenter < BasePresenter
  # build page tree from specified root_depth, default second level root with sitemap property to render a sitemap from top root of current page
  def tree(root_depth: 1, sitemap: false, nav_class: 'tree')
    return if m.parent_at_depth(root_depth).nil?
    @sitemap = sitemap
    h.content_tag :nav, class: nav_class do
      h.concat render_tree_master_ul(m.parent_at_depth(root_depth))
    end
  end

  # build page breadcrumbs from specified root_depth, default root
  def breadcrumbs(root_depth: 0, last_page_title: nil, nav_class: 'breadcrumbs', div_class: 'scrollable')
    return if m.parent_at_depth(root_depth).nil?
    h.content_tag :nav, class: nav_class do
      h.concat h.content_tag(:div, breadcrumbs_ul(breadcrumbs_list(root_depth, last_page_title)), class: div_class)
    end
  end

  private

  def breadcrumbs_list(root_depth = 0, last_page_title = nil, page = m)
    pages = []
    while page.present? && page.depth >= root_depth
      pages.unshift(page)
      page = page.parent
    end
    pages.push(OpenStruct.new({title: last_page_title})) if last_page_title.present?
    pages
  end

  def breadcrumbs_ul(pages)
    h.content_tag :ul do
      pages.each do |page|
        h.concat(breadcrumbs_li(page, (pages.last == page)))
      end
    end
  end

  def breadcrumbs_li(page, last_page)
    h.content_tag :li do
      h.concat (page.show_link && !last_page) ? h.link_to(page.title, page.url) : h.content_tag(:span, page.title)
    end
  end

  def render_tree_master_li(page)
    h.content_tag :li do
      h.concat h.content_tag(:span, (@sitemap ? h.link_to(page.title, page.url) : page.title), data: {:'js-drawer-mobile' => true})
      h.concat render_tree_ul_wrapper(page)
    end
  end

  def render_tree_ul_wrapper(page)
    h.content_tag :div do
      page.children.order(:tree_position).each do |child|
        h.concat render_tree_ul(child)
      end if (page.has_children? && (page != m || @sitemap))
    end
  end

  def render_tree_li(page)
    h.content_tag(:li, class: ('active' if (page.subtree.include?(m) && !@sitemap))) do
      h.concat h.link_to(page.title, page.url, class: ('active' if (page == m && !@sitemap)))
      page.children.order(:tree_position).each do |child|
        h.concat render_tree_ul(child)
      end if page.has_children? && (m.ancestors.include?(page) || m.subtree.include?(page) || @sitemap)
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