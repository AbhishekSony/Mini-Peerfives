# frozen_string_literal: true

class RewardHistory < ApplicationRecord
  belongs_to :giver, class_name: 'User', foreign_key: :given_by
  belongs_to :receiver, class_name: 'User', foreign_key: :given_to

  validates :points, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  after_create :update_balances_on_create
  after_destroy :update_balances_on_destroy

  private

  def update_balances_on_create
    giver.update!(p5_balance: giver.p5_balance - points)
    receiver.update!(reward_balance: (receiver.reward_balance || 0) + points)
  end

  def update_balances_on_destroy
    giver.update!(p5_balance: giver.p5_balance + points)
    receiver.update!(reward_balance: receiver.reward_balance - points)
  end
end
