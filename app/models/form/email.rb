module Form
  class Email < ActiveRecord::Base
    include Admin::Form::Email

    self.table_name_prefix = 'form_'

    has_one :structure

    def subject
      send("subject_#{I18n.locale}").presence || I18n.t('cms.form.email.default_subject')
    end

    def body
      send("body_#{I18n.locale}").presence || I18n.t('cms.form.email.default_body')
    end

    def send_to
      read_attribute(:send_to).presence || Setting[:cms_mail_bcc]
    end
  end
end
