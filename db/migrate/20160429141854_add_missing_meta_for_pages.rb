class AddMissingMetaForPages < ActiveRecord::Migration
  def change
    add_column :viewable_pages, :twitter_card, :string
    add_column :viewable_pages, :twitter_title, :string
    add_column :viewable_pages, :twitter_description, :text
    add_column :viewable_pages, :twitter_image, :string

    add_column :viewable_pages, :og_title, :string
    add_column :viewable_pages, :og_image, :string
    add_column :viewable_pages, :og_description, :text

    add_column :viewable_pages, :meta_general_image, :string

    Setting.apply_all(
      default_meta_title: '',
      default_meta_description: '',
      twitter_site: '',
      fb_app_id: '',
      default_twitter_card: '',
      default_twitter_title: '',
      default_twitter_description: '',
      default_og_title: '',
      default_og_site_name: '',
      default_og_description: '',
      meta_general_image: ''
    )
  end
end
