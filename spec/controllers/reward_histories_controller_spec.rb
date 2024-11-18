# frozen_string_literal: true

require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe RewardHistoriesController, type: :controller do
  let(:giver) { create(:user, p5_balance: 100) }
  let(:receiver) { create(:user, p5_balance: 100) }
  let(:reward_history) { create(:reward_history, giver: giver, receiver: receiver, points: 20) }

  describe 'GET #index' do
    it 'redirects if the user has no given rewards' do
      get :index, params: { id: giver.id }

      expect(response).to redirect_to(rewards_user_path(giver))
    end
  end

  describe 'GET #new' do
    it 'assigns a new RewardHistory to @reward_history and assigns @other_users' do
      get :new, params: { user_id: giver.id }
      expect(assigns(:reward_history)).to be_a_new(RewardHistory)
      expect(assigns(:other_users)).to include(receiver)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid points' do
      it 'creates a new reward history and updates balances' do
        post :create, params: { user_id: giver.id, reward_history: { points: 20, receiver_id: receiver.id } }
        giver.reload
        receiver.reload
        expect(giver.p5_balance).to eq(80) # 100 - 20 = 80
        expect(receiver.reward_balance).to eq(20) # receiver's reward_balance should be updated
        expect(response).to redirect_to(rewards_user_path(giver))
        expect(flash[:notice]).to eq('Reward given successfully')
      end
    end

    context 'with insufficient P5 points' do
      it 'does not create a reward history and shows an alert' do
        post :create, params: { user_id: giver.id, reward_history: { points: 200, receiver_id: receiver.id } }
        expect(giver.reload.p5_balance).to eq(100) # Balance should not change
        expect(flash[:alert]).to eq('Not enough P5 points')
        expect(response).to redirect_to(new_user_reward_history_path(giver))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the reward history and updates balances' do
      delete :destroy, params: { user_id: giver.id, id: reward_history.id }
      giver.reload
      receiver.reload
      expect(giver.p5_balance).to eq(100) # 80 + 20 = 100
      expect(receiver.p5_balance).to eq(100) # 120 - 20 = 100
      expect(response).to redirect_to(p5_user_path(giver))
      expect(flash[:notice]).to eq('Reward history deleted successfully')
    end
  end
end
