class RewardHistoriesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @rewards = @user.given_rewards
  end

  def new
    @user = User.find(params[:user_id])
    @other_users = User.where.not(id: @user.id)
    @reward_history = RewardHistory.new
  end

  def create
    @user = User.find(params[:user_id])
    receiver = User.find(params[:reward_history][:receiver_id])
    points = params[:reward_history][:points].to_i

    if @user.p5_balance >= points
      @reward_history = RewardHistory.new(given_by: @user.id, given_to: receiver.id, points: points)

      if @reward_history.save
        @user.update!(p5_balance: (@user.p5_balance - points).to_i)
        receiver.update!(rewards_balance: ((receiver.rewards_balance || 0) + points).to_i)
        redirect_to user_reward_histories_path(@user), notice: 'Reward given successfully'
      else
        render :new
      end
    else
      redirect_to new_user_reward_history_path(@user), alert: 'Not enough P5 points'
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to user_reward_histories_path(@user), alert: "Error: #{e.message}"
  end

  def destroy
    @reward_history = RewardHistory.find(params[:id])
    giver = User.find(@reward_history.given_by)
    receiver = User.find(@reward_history.given_to)

    giver.p5_balance += @reward_history.points
    receiver.reward_balance -= @reward_history.points
    giver.save
    receiver.save

    @reward_history.destroy
    redirect_to user_rewards_path(giver)
  end
end
