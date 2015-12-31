module CMS
  class FormsController < RailsAdminCMS::Config.parent_controller
    attr_internal :cms_form_instance

    helper_method :cms_form_instance

    def new
      load_form

      render new_template
    end

    def create
      load_form

      if cms_form_instance.save
        if cms_form_instance.send_email?
          FormsMailer.send_email(cms_form_instance).deliver_now
        end
        reset_form
        flash_now!(:success)
      else
        flash_now!(error: cms_form_instance.errors.full_messages.first)
      end

      respond_to do |format|
        format.js {}
        format.html do
          render new_template
        end
      end
    end

    private

    def load_form
      attributes = form_params if params.has_key?(form_key)
      self.cms_form_instance ||= form_class.new(attributes)
    end

    def reset_form
      self.cms_form_instance = form_object
    end

    def new_template
      "cms/forms/#{form_name}/new"
    end

    def form_params
      if form_class.has_collections?
        form_class.collections.each do |collection|
          params[form_key][collection] = "[#{params[form_key][collection].reject(&:blank?).join('][')}]"
        end
      end
      params.require(form_key).permit(form_attributes)
    end

    def form_attributes
      attributes = form_object.attributes.keys
      attributes = attributes.reject{ |key| %w[ id ].include? key } << '_subtitle'
      if form_class.has_attachments?
        attributes = attributes.concat(form_class.attachments)
      end
      attributes
    end

    def form_key
      @_form_key ||= "form_#{form_name}"
    end

    def form_object
      @_form_object ||= form_class.new
    end

    def form_class
      @_form_class ||= "Form::#{form_name.camelize}".constantize
    end

    def form_name
      @_form_name ||= params[:id]
    end
  end
end
