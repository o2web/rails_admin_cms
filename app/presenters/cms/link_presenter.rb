class CMS::LinkPresenter < CMS::PagePresenter
  def link_to(name = nil, options = {})
    h.active_link_to *normalize_link_options(name, options)
  end

  def li_link_to(name = nil, options = {})
    li_sortable_tag options[:li] do
      h.active_link_to *normalize_link_options(name, options)
    end
  end

  def li_link_to_with_edit(name = nil, options = {})
    li_sortable_tag options[:li] do
      h.concat h.active_link_to(*normalize_link_options(name, options))
      h.concat edit_link
    end
  end

  def youtube_embed_url(width = 420, height = 315)
    if (url = m.url)
      link = YouTubeAddy.youtube_embed_url(url, width, height)
      # verify url validity
      unless link[/\[\/\^/]
        link.html_safe
      end
    end
  end

  def url(options = {})
    @url ||= begin
      if m.file.present?
        h.main_app.file_path(id: m)
      else
        m.page.presence || m.url.presence || options[:path] || options[:url] || '#'
      end
    end
  end

  def active?(options = {})
    @active ||= begin
      path = url(options)
      if path == '#' || path[/^http/]
        false
      else
        !!(h.request.path =~ /^#{path}/)
      end
    end
  end

  private

  def normalize_link_options(name, options)
    name = m.title.presence || name
    if m.target_blank?
      options = options.merge target: '_blank'
    end
    if !m.turbolink?
      options = options.merge 'data-no-turbolink' => true
    end
    [name, url(options), options]
  end
end