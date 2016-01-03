FactoryGirl.define do
  factory :unique_key, aliases: [:unique_key_fr] do
    viewable_type "Viewable::Link"
    view_path "cms/pages/page"
    name 'test'
    sequence(:position) { |i| i }
    locale 'fr'
    association :viewable, factory: :viewable_link
  end

  factory :unique_key_en, class: UniqueKey do
    viewable_type "Viewable::Link"
    view_path "cms/pages/page"
    name 'test'
    sequence(:position) { |i| i }
    locale 'en'
    association :viewable, factory: :viewable_link
  end
end
