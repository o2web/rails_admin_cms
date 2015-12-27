module RailsAdmin
  FormBuilder.class_eval do

    private

    def nested_field_association?(field, nested_in)
      field.inverse_of.presence && nested_in.presence && field.inverse_of == nested_in.name &&
        (@template.instance_variable_get(:@model_config).abstract_model == field.abstract_model || field.name == nested_in.inverse_of)
    end
  end
end
