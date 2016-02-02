module CMS
  class MailchimpController < RailsAdminCMS::Config.parent_controller
    invisible_captcha only: [:subscribe]

    def subscribe
      respond_to do |format|
        format.js do
          begin
            gb = Gibbon::API.new(Rails.application.secrets.mailchimp_api_key, { timeout: 15 })
            gb.lists.subscribe(
              id: Rails.application.secrets.send(:"mailchimp_list_id_#{I18n.locale}"),
              email: { email: params[:mailchimp][:email] },
              double_optin: false
            )
            flash_now!(:success)
          rescue Gibbon::MailChimpError => exception
            cms_logger exception, 'mailchimp'
            flash_now!(:error)
          end
        end
      end
    end
  end
end
