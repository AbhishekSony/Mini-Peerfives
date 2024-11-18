# frozen_string_literal: true

FactoryBot.define do
  factory :reward_history do
    points { 10 }
    association :giver, factory: :user
    association :receiver, factory: :user
  end
end
