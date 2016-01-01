module CMS
  class PagesController < RailsAdminCMS::Config.parent_controller
    def show
      @page = Viewable::Page.find(params[:id]) if params[:id].present?

      if @page
        render @page.view_path
      else
        render "cms/pages/#{params[:page]}"
      end
    end
  end
end
