module CMS
  class PagesController < RailsAdminCMS::Config.parent_controller
    def show
      @cms_view = Viewable::Page.find(params[:id]) if params[:id].present?

      if @cms_view
        render @cms_view.view_path
      else
        render "cms/pages/#{params[:cms_view_type]}"
      end
    end
  end
end
