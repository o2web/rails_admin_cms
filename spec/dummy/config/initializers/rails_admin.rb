RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except Viewable.models + %w[ UniqueKey ]
    end
    export do
      except Viewable.models + %w[ UniqueKey ]
    end
    bulk_delete do
      except %w[ UniqueKey ]
    end
    show do
      except %w[ UniqueKey ]
    end
    edit do
      except %w[ UniqueKey ]
    end
    delete do
      except %w[ UniqueKey ]
    end
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
