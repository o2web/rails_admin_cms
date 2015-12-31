module Form
  extend ActiveSupport::Concern

  included do
    attr_accessor :_subtitle

    validates :_subtitle, invisible_captcha: true
  end

  class_methods do
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

      define_method :collections do
        self.class.collections
      end
    end
  end

  def form_name
    model_name.element
  end

  def send_email?
    respond_to? :send_to
  end

  def has_attachments?
    self.class.has_attachments?
  end

  def has_collections?
    self.class.has_collections?
  end

  class << self
    def pages
      @_pages ||= Dir["#{Rails.root}/app/views/cms/forms/*"].select{ |name|
        File.directory? name
      }.map{ |name|
        name.split('/').last
      }
    end
  end
end
