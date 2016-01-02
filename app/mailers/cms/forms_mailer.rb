module CMS
  class FormsMailer < RailsAdminCMS::Config.parent_mailer
    def send_email(form)
      options = {
        from: form.send_from,
        to: form.send_to,
        bcc: Setting[:cms_mail_bcc],
        subject: form.send_subject,
        template_name: form.form_name,
      }

      if form.has_attachments?
        options[:content_type] = 'multipart/form-data'
        form.attachments.each do |name|
          attachment = form.send(name)
          next unless attachment.exists?
          attachments[attachment.original_filename] = File.read(attachment.path)
        end
      end

      @form = form
      mail options

      # https://github.com/rails/rails/issues/2686
      fix_mixed_attachments
    end

    def fix_mixed_attachments
      # do nothing if we have no actual attachments
      return if @_message.parts.select { |p| p.attachment? && !p.inline? }.none?

      mail = Mail.new

      related = Mail::Part.new
      related.content_type = @_message.content_type
      @_message.parts.select { |p| !p.attachment? || p.inline? }.each { |p| related.add_part(p) }
      mail.add_part related

      mail.header       = @_message.header.to_s
      mail.bcc          = @_message.header[:bcc].value # copy bcc manually because it is omitted in header.to_s
      mail.content_type = nil
      @_message.parts.select { |p| p.attachment? && !p.inline? }.each { |p| mail.add_part(p) }

      @_message = mail
      wrap_delivery_behavior!(delivery_method.to_sym)
    end
  end
end
