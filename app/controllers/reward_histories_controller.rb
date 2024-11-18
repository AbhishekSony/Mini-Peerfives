# frozen_string_literal: true

class RewardHistoriesController < ApplicationController
  before_action :set_user, only: %i[index new create]
  before_action :set_reward_history, only: :destroy

  def index
    @rewards = @user.given_rewards
    return unless @rewards.empty?

    redirect_to rewards_user_path(@user)
  end

  def new
    @other_users = User.where.not(id: @user.id)
    @reward_history = RewardHistory.new
  end

  def create
    @reward_history = @user.given_rewards.build(reward_history_params)

    if @user.p5_balance < @reward_history.points
      redirect_to new_user_reward_history_path(@user), alert: 'Not enough P5 points'
      return
    end

    if @reward_history.save
      redirect_to rewards_user_path(@user), notice: 'Reward given successfully'
    else
      render :new, alert: 'Error: Unable to give reward'
    end
  end

  def destroy
    @reward_history.destroy
    redirect_to p5_user_path(@reward_history.giver),
                notice: 'Reward history deleted successfully'
  end

  private

  def set_user
    @user = User.find(params[:user_id] || params[:id])
  end

  def set_reward_history
    @reward_history = RewardHistory.find(params[:id])
  end

  def reward_history_params
    params.require(:reward_history).permit(:points).merge(given_to: params[:reward_history][:receiver_id])
  end
end
