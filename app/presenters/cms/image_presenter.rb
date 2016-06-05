class CMS::ImagePresenter < CMS::ElementPresenter
  def path
    m.image
  end

  def url
    "#{h.request.base_url}#{path}" if path.present?
  end
end