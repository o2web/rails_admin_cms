module Form
  class Contact < Form::Object
    include Admin::Form::Object
    include Form::Email
    include Form::Attachment

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
