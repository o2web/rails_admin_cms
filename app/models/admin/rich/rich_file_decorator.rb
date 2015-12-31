module Rich
  RichFile.class_eval do
    rails_admin do
      navigation_label I18n.t('rich.navigation')
      label I18n.t('rich.file.one')
      label_plural I18n.t('rich.file.other')

      configure :rich_file, :jcrop

      field :rich_file do
        fit_image true
      end
      field :owner_type
    end

    def owner_type_enum
      ['cms']
    end
  end
end
