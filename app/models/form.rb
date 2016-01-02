module Form
  extend ActiveSupport::Concern

  included do
    self.abstract_class = true

    attr_accessor :_subtitle

    validates :_subtitle, invisible_captcha: true

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

  def form_name
    model_name.element
  end

  def send_email?
    respond_to? :send_to
  end

  class << self
    def names
      @_names ||= Dir["#{Rails.root}/app/views/cms/forms/*"].select{ |name|
        File.directory? name
      }.map{ |name|
        name.split('/').last
      }
    end
  end
end
