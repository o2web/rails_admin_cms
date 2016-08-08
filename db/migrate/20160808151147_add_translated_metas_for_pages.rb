class AddTranslatedMetasForPages < ActiveRecord::Migration
  def change

    Setting.remove_all(
      :default_meta_title,
      :default_meta_description,
      :twitter_site,
      :fb_app_id,
      :default_twitter_card,
      :default_twitter_title,
      :default_twitter_description,
      :default_og_title,
      :default_og_site_name,
      :default_og_description,
      :meta_general_image
    )

    Setting.apply_all(
      default_meta_title_fr: '',
      default_meta_description_fr: '',
      twitter_site_fr: '',
      fb_app_id_fr: '',
      default_twitter_card_fr: '',
      default_twitter_title_fr: '',
      default_twitter_description_fr: '',
      default_og_title_fr: '',
      default_og_site_name_fr: '',
      default_og_description_fr: '',
      meta_general_image_fr: '',
      default_meta_title_en: '',
      default_meta_description_en: '',
      twitter_site_en: '',
      fb_app_id_en: '',
      default_twitter_card_en: '',
      default_twitter_title_en: '',
      default_twitter_description_en: '',
      default_og_title_en: '',
      default_og_site_name_en: '',
      default_og_description_en: '',
      meta_general_image_en: ''
    )
  end
end
