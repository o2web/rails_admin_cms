module Form
  class Row::AsHeader < Row
    include Admin::Form::Row::AsHeader

    before_save :set_label

    alias_attribute :label, :locale

    def with_email?
      false
    end

    private

    def set_label
      self.label = I18n.t('cms.form.header', locale: I18n.default_locale)
    end
  end
end
