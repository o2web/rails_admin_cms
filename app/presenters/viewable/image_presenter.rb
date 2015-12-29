module Viewable
  class ImagePresenter < ViewablePresenter
    def image_url
      "#{h.request.base_url}#{m.image_path}" if m.image_path.present?
    end
  end
end
