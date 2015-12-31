module Rich
  RichFile.class_eval do
    alias_attribute :name, :rich_file_file_name

    # TODO: update associations file_name after update

    rails_admin do
      navigation_label I18n.t('rich.navigation')
      label I18n.t('rich.file.one')
      label_plural I18n.t('rich.file.other')

      configure :rich_file, :jcrop

      list do
        field :rich_file
        field :rich_file_file_name
        field :simplified_type
        field :owner_type
      end

      show do
        field :rich_file
        field :owner_type
      end

      edit do
        field :rich_file do
          fit_image true
        end
        field :owner_type
      end
    end

    def owner_type_enum
      ['cms']
    end
  end
end
