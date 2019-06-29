require 'faker'
FactoryBot.define do
  factory :board do
    name { "Daily report" }
    trait :with_image do
      front_image { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-image.png'), 'image/png') }
    end
  end
end
