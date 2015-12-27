module CMS
  class PagesController < RailsAdminCMS::Config.parent_controller
    def show
      render "cms/pages/#{params[:id]}"
    end
  end
end
