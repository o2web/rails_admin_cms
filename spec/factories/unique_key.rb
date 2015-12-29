FactoryGirl.define do
  factory :unique_key, aliases: [:unique_key_fr] do
    viewable_type "Viewable::Link"
    view_path "cms/pages/page"
    name 'test'
    sequence(:position) { |i| i }
    locale 'fr'
    after(:create) do |unique_key|
      unique_key.viewable = create(:viewable_link)
      unique_key.save!
    end
  end

  factory :unique_key_en, class: UniqueKey do
    viewable_type "Viewable::Link"
    view_path "cms/pages/page"
    name 'test'
    sequence(:position) { |i| i }
    locale 'en'
    after(:create) do |unique_key|
      unique_key.viewable = create(:viewable_link)
      unique_key.save!
    end
  end
end
