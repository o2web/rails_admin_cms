module CMS
  class ViewablesController < RailsAdminCMS::Config.parent_controller
    before_action RailsAdminCMS::Config.authentication_method

    def create
      current_count = UniqueKey.where(list_key_params).count

      if params[:max] == 'Infinity' || current_count < params[:max].to_i
        unique_key = list_key_params.merge(position: current_count + 1)

        viewable = UniqueKey.create_localized_viewable!(unique_key)

        path = rails_admin.edit_path(model_name: unique_key[:viewable_type].to_s.underscore.gsub('/', '~'), id: viewable.id)

        redirect_to path
      else
        redirect_to :back
      end
    end

    def update
      unique_key = UniqueKey.find(params[:id])

      unique_key.update!(unique_key_params)

      render nothing: true
    end

    private

    def list_key_params
      params.require(:list_key).permit(:viewable_type, :view_path, :name, :locale)
    end

    def unique_key_params
      params.require(:unique_key).permit(:position)
    end
  end
end
