# Clean up when merging w master

def open_asset(file_name)
  File.open(Rails.root.join('db', 'seed_assets', file_name))
end

FactoryGirl.define do
  factory :product do
    name          { Faker::Hipster.sentence(3) }
    description   { Faker::Hipster.paragraph(4) }
    image         { open_asset('apparel1.jpg') }
    quantity      { rand(10) }
    price         { 25.00 }
  end
end
