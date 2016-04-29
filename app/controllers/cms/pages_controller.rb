module CMS
  class PagesController < RailsAdminCMS::Config.parent_controller
    before_action :find_page_view
    after_action :allow_iframe

    def find_page_view
      @cms_view = Viewable::Page.find(params[:page_id]) if params[:page_id].present? && params[:parent_id].blank?
    end

    def find_page_parent_view(show_page = nil)
      @cms_view = Viewable::Page.find(params[:parent_id]) if params[:parent_id].present?
      add_show_page_meta show_page unless show_page.nil?
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

    def add_show_page_meta(show_page)
      %i(
        meta_title
        meta_description
        meta_keywords
        meta_general_image
        twitter_card
        twitter_title
        twitter_description
        twitter_image
        og_title
        og_image
        og_description
      ).each do |meta|
        @cms_view.send("#{meta}=", show_page.send(meta)) if show_page.send(meta).present?
      end
    end
  end
end
