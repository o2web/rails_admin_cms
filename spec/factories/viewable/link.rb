FactoryGirl.define do
  factory :viewable_link, class: Viewable::Link do
    title 'test'
    url nil
    page '/page'
    file nil
    target_blank false
    turbolink true
  end
end
