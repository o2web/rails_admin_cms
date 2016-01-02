module Form
  module Static
    module Email
      extend ActiveSupport::Concern

      def send_subject
        I18n.t('cms.form.email.default_subject')
      end

      def send_from
        try(:email)
      end

      def send_to
        Setting[:cms_mail_bcc]
      end

      def send_email?
        true
      end
    end
  end
end
