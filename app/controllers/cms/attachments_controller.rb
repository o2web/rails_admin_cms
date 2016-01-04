module CMS
  class AttachmentsController < RailsAdminCMS::Config.parent_controller
    before_action :authenticate_admin_user!

    def show
      name, format = params[:file].sub(/\?.+$/, ''), params[:format]
      file_name = "#{name}.#{format}"
      content_type = Mime::Type.lookup_by_extension(format)

      send_file(
        "#{Rails.root}/private/attachments/#{params[:directory]}/#{file_name}",
        type: content_type,
        filename: file_name,
        disposition: 'inline',
        x_sendfile: !Rails.env.development?,
        stream: true
      )
    end
  end
end
