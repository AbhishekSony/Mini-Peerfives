# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RewardHistory, type: :model do
  let!(:giver) { create(:user, name: 'Giver', p5_balance: 100) }
  let!(:receiver) { create(:user, name: 'Receiver', reward_balance: 0) }

  describe 'validations' do
    it { should validate_numericality_of(:points).is_greater_than(0).is_less_than_or_equal_to(100) }
  end

  describe 'callbacks' do
    context 'after create' do
      it 'updates giver and receiver balances' do
        create(:reward_history, giver: giver, receiver: receiver, points: 10)

        giver.reload
        receiver.reload
        expect(giver.p5_balance).to eq(90)
        expect(receiver.reward_balance).to eq(10)
      end
    end

    context 'after destroy' do
      it 'reverts balances' do
        reward_history = create(:reward_history, giver: giver, receiver: receiver, points: 10)
        reward_history.destroy

        giver.reload
        receiver.reload
        expect(giver.p5_balance).to eq(100)
        expect(receiver.reward_balance).to eq(0)
      end
    end
  end
end
