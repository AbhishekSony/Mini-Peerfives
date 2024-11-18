# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    p5_balance { 100 }
    reward_balance { 0 }
  end
end
