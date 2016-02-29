module CMS
  class PagesController < RailsAdminCMS::Config.parent_controller
    before_action :find_page_view
    after_action :allow_iframe

    def find_page_view
      @cms_view = Viewable::Page.find(params[:id]) if params[:id].present? && params[:parent_id].blank?
    end

    def find_page_parent_view
      @cms_view = Viewable::Page.find(params[:parent_id]) if params[:parent_id].present?
    end

    def show
      if @cms_view
        render @cms_view.view_path
      else
        render "cms/pages/#{params[:cms_view_type]}"
      end
    end

    private

    def allow_iframe
      if RailsAdminCMS::Config.allow_iframe_from.present?
        response.headers['X-FRAME-OPTIONS'] = RailsAdminCMS::Config.allow_iframe_from
      end
    end
  end
end
