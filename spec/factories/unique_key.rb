FactoryGirl.define do
  factory :unique_key do
    viewable = Viewable.models.sample

    viewable_type viewable
    view_path "cms/pages/#{Viewable.pages.sample}"
    name Faker::Internet.slug
    position Faker::Number.number(1)
    locale { I18n.available_locales.sample }
    after(:create) do |unique_key|
      unique_key.viewable = create(viewable.constantize.underscored_name.to_sym)
      unique_key.save!
    end
  end
end
