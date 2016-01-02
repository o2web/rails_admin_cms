module Form
  class Contact < Static::Object
    include Admin::Form::Static::Object

    include Static::Email
    include Static::Attachment

    has_attachments :letter, :resume
    has_collections :periods

    attribute :name, :string
    attribute :email, :string
    attribute :country, :string
    attribute :periods, :text

    validates :name, presence: true
    validates :email, email: true, presence: true
  end
end
