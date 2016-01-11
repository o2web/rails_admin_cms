class AddCmsOgTagsSettings < ActiveRecord::Migration
  def change
    def up
      Setting.apply_all(
        cms_og_tag_title: Rails.application.class.parent_name,
        cms_og_tag_description: Rails.application.class.parent_name,
      )
    end
    def down
      Setting.remove_all(
        :cms_og_tag_title,
        :cms_og_tag_description,
      )
    end
  end
end
