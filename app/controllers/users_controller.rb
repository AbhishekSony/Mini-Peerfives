# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit show update p5_balance]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def show; end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def p5_balance; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :p5_balance)
  end
end
