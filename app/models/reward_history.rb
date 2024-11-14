class RewardHistory < ApplicationRecord
  belongs_to :giver, class_name: 'User', foreign_key: :given_by
  belongs_to :receiver, class_name: 'User', foreign_key: :given_to

  validates :points, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
end
