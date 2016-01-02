module Form
  module Attachment
    extend ActiveSupport::Concern

    class_methods do
      def has_attachments(*attachments)
        define_singleton_method :attachments do
          attachments
        end

        delegate :attachments, to: :class

        if virtual?
          attachments.each do |attachment|
            attribute "#{attachment}_file_name",    :string
            attribute "#{attachment}_content_type", :string
            attribute "#{attachment}_file_size",    :integer
            attribute "#{attachment}_updated_at",   :datetime
          end
        end

        attachments.each do |attachment|
          has_attached_file attachment,
            url: "/attachments/:class/:id_partition/:basename.:extension",
            path: ":rails_root/private/attachments/:class/:id_partition/:basename.:extension"

          validates_attachment_content_type attachment, { content_type: %w[
            text/plain
            application/pdf
            application/msword
            application/vnd.openxmlformats-officedocument.wordprocessingml.document
            image/jpeg
            image/png
            image/gif
          ] }
          validates_attachment_file_name attachment, matches: [
            /txt\Z/i,
            /pdf\Z/i,
            /doc\Z/i,
            /docx\Z/i,
            /jpe?g\Z/i,
            /png\Z/i,
            /gif\Z/i,
          ]
          validates_attachment_size attachment, less_than: 5.megabytes
        end

        before_post_process :normalize_attachment
      end
    end

    private

    def normalize_attachment
      attachments.each do |attachment|
        Rich::Backends::Paperclip.normalize_attachment(attachment)
      end
    end
  end
end
