module Form
  class Contact < Static::Object # < Static::Base
    include Admin::Form::Static::Object

    include Static::Email
    include Static::Attachment

    # has_attachments :letter, :resume
    has_collections :periods

    attribute :name, :string
    attribute :email, :string
    attribute :periods, :text

    with_options presence: true do
      validates :name
      validates :email, email: true
    end
  end
end
