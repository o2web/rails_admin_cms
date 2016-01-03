module Form
  module Static
    module Email
      extend ActiveSupport::Concern

      def subject
        I18n.t('cms.form.email.default_subject')
      end

      def send_from
        try(:email)
      end

      def send_to
        Setting[:cms_mail_bcc]
      end

      def with_email?
        true
      end
    end
  end
end
