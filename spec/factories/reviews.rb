
FactoryGirl.define do
  factory :review do
    description   { Faker::Hipster.paragraph(2) }
    rating        { rand(6) }
  end
end
