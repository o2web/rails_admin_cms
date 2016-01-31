module CMS
  class PagesController < RailsAdminCMS::Config.parent_controller
    after_action :allow_iframe, if: RailsAdminCMS::Config.allow_iframe_from

    def show
      @cms_view = Viewable::Page.find(params[:id]) if params[:id].present?

      if @cms_view
        render @cms_view.view_path
      else
        render "cms/pages/#{params[:cms_view_type]}"
      end
    end

    private

    def allow_iframe
      response.headers['X-FRAME-OPTIONS'] = RailsAdminCMS::Config.allow_iframe_from
    end
  end
end
