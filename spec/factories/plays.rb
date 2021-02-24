FactoryBot.define do
  factory :play do
    title           {Faker::Name.name}
    area_id         {Faker::Number.between(from: 2, to: 48)}
    place           {"埼玉スタジアム2002"}
    ground_style_id {Faker::Number.between(from: 2, to: 5)}
    published_at    {"2022-02-22 22:22:00"}
    detail          {"なにか主コメント"}
    association :user
  end
end