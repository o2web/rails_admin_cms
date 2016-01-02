module Form
  class Job < Static::Base
    include Static::Email
    include Static::Attachment

    has_attachments :letter, :resume
    has_collections :periods

    validates :name, presence: true
    validates :email, email: true, presence: true
  end
end
