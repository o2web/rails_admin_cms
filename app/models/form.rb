module Form
  extend ActiveSupport::Concern

  included do
    attr_accessor :_subtitle

    validates :_subtitle, invisible_captcha: true

    before_save :set_locale
    after_save  :send_email, if: :with_email?

    delegate :virtual?, :has_attachments?, :has_collections?, to: :class
  end

  class_methods do
    def virtual?
      false
    end

    def has_attachments?
      respond_to? :attachments
    end

    def has_collections?
      respond_to? :collections
    end

    def has_collections(*collections)
      define_singleton_method :collections do
        collections
      end

      delegate :collections, to: :class
    end
  end

  class << self
    def structure_models
      %w[
        Form::Structure
        Form::Field
        Form::Email
      ]
    end
  end

  private

  def set_locale
    if has_attribute?(:locale) && locale.nil?
      self.locale = I18n.locale
    end
  end

  def send_email
    CMS::FormsMailer.send_email(self).deliver_later
  end
end
