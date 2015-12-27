FactoryGirl.define do
  factory :viewable_link, class: Viewable::Link do
    title Faker::Book.title
    link [nil, '', '/', '/page'].sample
    page [nil, ''].concat(Viewable::Link.new.page_enum).sample
    target_blank [false, true].sample
    turbolink [false, true].sample
  end
end
