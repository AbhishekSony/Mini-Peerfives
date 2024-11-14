class User < ApplicationRecord
  has_many :given_rewards, class_name: 'RewardHistory', foreign_key: :given_by
  has_many :received_rewards, class_name: 'RewardHistory', foreign_key: :given_to

  validates :name, presence: true

end
