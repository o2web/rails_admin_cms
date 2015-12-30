class AddCMSMailFromAndBccSettings < ActiveRecord::Migration
  def up
    Setting.apply_all(
      cms_mail_from: 'rails@admin.cms',
      cms_mail_bcc: 'rails@admin.cms',
    )
  end
  def down
    Setting.remove_all(
      :cms_mail_from,
      :cms_mail_bcc,
    )
  end
end
