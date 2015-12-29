module CMS
  class FilesController < RailsAdminCMS::Config.parent_controller
    def show
      file_path = Viewable::Link.find(params[:id]).file
      file_name = File.basename(file_path)
      ext = File.extname(file_name).sub('.', '')
      content_type = Mime::Type.lookup_by_extension(ext)

      send_file(
        "#{Rails.root}/public#{file_path}",
        type: content_type,
        filename: file_name,
        disposition: 'inline',
        x_sendfile: !Rails.env.development?,
        stream: true
      )
    end
  end
end
