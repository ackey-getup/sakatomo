FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials }
    email                 { Faker::Internet.free_email }
    password              { '123abc' }
    password_confirmation { password }
    profile               { 'profile' }
    position_id           { Faker::Number.between(from: 2, to: 5) }
    play_style_id         { Faker::Number.between(from: 2, to: 5) }
    play_experience_id    { Faker::Number.between(from: 2, to: 7) }
    main_play_area_id     { Faker::Number.between(from: 2, to: 48) }
  end
end
