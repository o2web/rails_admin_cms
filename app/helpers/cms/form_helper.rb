module CMS
  module FormHelper
    def cms_form_for(options = {})
      simple_form_for(cms_form_instance, cms_form_options(options)) do |f|
        concat f.invisible_captcha(:_subtitle)
        yield f
        if @cms_view
          concat f.input(:structure_id, as: :hidden, input_html: { value: cms_form_instance.structure_id })
        end
      end
    end

    def cms_form_options(options = {})
      if @cms_view
        url = @cms_view.url
      else
        url = main_app.__send__("#{cms_form_instance.form_name}_path")
      end
      options.reverse_merge! url: url
      if cms_form_instance.has_attachments?
        options[:multipart] = true
      else
        options[:remote] = true
      end
      options
    end

    def cms_form_partial
      "cms/forms/#{params[:cms_view_type]}/form"
    end

    def cms_validates(options = {})
      type, required = options.extract!(*Form::Field::TYPES.map(&:to_sym)).first
      unless type
        return cms_validate_presence(options)
      end
      unless required
        return options
      end
      case type
      when :check_boxes
        cms_validate_check_boxes(options)
      when :email
        cms_validate_email(options)
      else
        cms_validate_presence(options)
      end
    end

    def cms_validate_presence(options = {})
      { 'data-validation' => 'required', 'data-validation-error-msg' => t('errors.messages.blank') }.merge(options)
    end

    def cms_validate_email(options = {})
      { 'data-validation' => 'email', 'data-validation-error-msg' => t('errors.messages.invalid') }.merge(options)
    end

    def cms_validate_check_boxes(options = {})
      { 'data-validation' => 'checkbox_group', 'data-validation-qty' => 'min1', 'data-validation-error-msg' => t('errors.messages.blank') }.merge(options)
    end

    def cms_form_send
      t('cms.form.submit.send')
    end

    def cms_form_sending(options = {})
      { 'data-disable-with' => t('cms.form.submit.sending') }.merge(options)
    end
  end
end
