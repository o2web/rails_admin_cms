module Viewable
  class LinkPresenter < ViewablePresenter
    def link_to(name = nil, options = {})
      h.link_to *normalize_link_options(name, options)
    end

    def li_link_to(name = nil, options = {})
      li_tag do
        h.link_to *normalize_link_options(name, options)
      end
    end

    def li_link_to_with_edit(name = nil, options = {})
      li_tag do
        h.concat h.link_to(*normalize_link_options(name, options))
        h.concat edit_link
      end
    end

    def active_link_to(name = nil, options = {})
      h.active_link_to *normalize_link_options(name, options)
    end

    def li_active_link_to(name = nil, options = {})
      li_tag do
        h.active_link_to *normalize_link_options(name, options)
      end
    end

    def li_active_link_to_with_edit(name = nil, options = {})
      li_tag do
        h.concat h.active_link_to(*normalize_link_options(name, options))
        h.concat edit_link
      end
    end

    def youtube_embed_url(width = 420, height = 315)
      if (link = m.link)
        link = YouTubeAddy.youtube_embed_url(link, width, height)
        # verify link validity
        unless link[/\[\/\^/]
          link.html_safe
        end
      end
    end

    def url(options = {})
      m.page.presence || m.link.presence || options[:path] || options[:url] || '#'
    end

    private

    def li_tag
      options = h.edit_mode? ? { 'data-cms-sortable-id' => m.unique_key.id } : {}
      h.content_tag :li, options do
        yield
      end
    end

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
end
