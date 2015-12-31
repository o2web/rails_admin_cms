module CMS
  module FormHelper
    def cms_form_for(options = {})
      simple_form_for(cms_form_instance, cms_form_options(options)) do |f|
        concat f.invisible_captcha(:_subtitle)
        yield f
      end
    end

    def cms_form_options(options = {})
      options = { url: main_app.__send__("#{cms_form_instance.form_name}_path") }.merge(options)
      if cms_form_instance.has_attachments?
        options[:multipart] = true
      else
        options[:remote] = true
      end
      options
    end

    def cms_form_partial
      "cms/forms/#{cms_form_instance.form_name}/form"
    end

    def cms_validate_presence(options = {})
      if options.delete(:check_boxes)
        { 'data-validation' => 'checkbox_group', 'data-validation-qty' => 'min1', 'data-validation-error-msg' => t('errors.messages.blank') }.merge(options)
      else
        { 'data-validation' => 'required', 'data-validation-error-msg' => t('errors.messages.blank') }.merge(options)
      end
    end

    def cms_validate_email(options = {})
      { 'data-validation' => 'email', 'data-validation-error-msg' => t('errors.messages.invalid') }.merge(options)
    end

    def cms_form_send
      t('cms.form.submit.send')
    end

    def cms_form_sending(options = {})
      { 'data-disable-with' => t('cms.form.submit.sending') }.merge(options)
    end
  end
end
