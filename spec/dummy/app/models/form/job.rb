module Form
  class Job < Form::Base
    include Form::Email
    include Form::Attachment

    has_attachments :letter, :resume
    has_collections :periods

    validates :name, presence: true
    validates :email, email: true, presence: true
  end
end
