module RailsAdmin
  ApplicationController.class_eval do
    include CMS::Localize

    before_action :set_paper_trail_whodunnit

    def user_for_paper_trail
      current_admin.try(:id) || current_admin
    end

    def paper_trail_enabled_for_controller
      true
    end

    private

    def set_paper_trail_whodunnit
      ::PaperTrail.whodunnit = user_for_paper_trail
    end
  end
end
