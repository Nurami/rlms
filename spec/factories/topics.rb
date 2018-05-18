FactoryGirl.define do
  factory :topic do
    course
    title { FFaker::Lorem.sentence(3) }
    slug { FFaker::Internet.slug(FFaker::Lorem.sentence(3), "-")}
  end
end
