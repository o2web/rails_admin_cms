module Form
  module Email
    extend ActiveSupport::Concern

    def subject
      I18n.t('cms.form.email.default_subject')
    end

    def send_from
      try(:email) || Setting[:cms_mail_from]
    end

    def send_to
      Setting[:cms_mail_bcc]
    end
  end
end
