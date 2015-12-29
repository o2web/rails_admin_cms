module Viewable
  class ImagePresenter < ViewablePresenter
    def path
      m.image
    end

    def url
      "#{h.request.base_url}#{path}" if path.present?
    end
  end
end
