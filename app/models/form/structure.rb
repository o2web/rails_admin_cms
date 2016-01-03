module Form
  class Structure < ActiveRecord::Base
    include Admin::Form::Structure

    self.table_name_prefix = 'form_'

    has_one :viewable, class_name: 'Viewable::Form'
    has_many :fields, -> { order(:position) }, dependent: :destroy
    has_many :rows, -> { order(:id) }, dependent: :destroy

    validates :fields, length: { maximum: RailsAdminCMS::Config.custom_form_max_size }

    after_create :create_header
    after_commit :expire_cache

    accepts_nested_attributes_for :fields, allow_destroy: true

    def send_subject
      send("send_subject_#{I18n.locale}").presence || I18n.t('cms.form.email.default_subject')
    end

    def send_to
      read_attribute(:send_to).presence || Setting[:cms_mail_bcc]
    end

    def email_column_key
      @email_column_key ||= fields.where(type: 'Form::Field::Email').first.try(:column_key)
    end

    def header
      rows.first
    end

    private

    def create_header
      rows.create!
    end

    def expire_cache
      viewable.touch
    end
  end
end
