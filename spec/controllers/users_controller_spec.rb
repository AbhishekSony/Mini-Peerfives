# frozen_string_literal: true

require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, name: 'Test User', p5_balance: 100) }

  describe 'GET #index' do
    it 'assigns @users and renders the index template' do
      get :index
      expect(assigns(:users)).to eq([user])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new user to @user and renders the new template' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user and redirects to the show page' do
        post :create, params: { user: { name: 'New User', p5_balance: 100 } }
        expect(assigns(:user).name).to eq('New User')
        expect(response).to redirect_to(user_path(assigns(:user)))
      end
    end

    context 'with invalid attributes' do
      it 'does not create a user and renders the new template' do
        post :create, params: { user: { name: '', p5_balance: 100 } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested user to @user and renders the edit template' do
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user to @user and renders the show template' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
      expect(response).to render_template(:show)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the user and redirects to the users list' do
        patch :update, params: { id: user.id, user: { name: 'Updated User' } }
        expect(user.reload.name).to eq('Updated User')
        expect(response).to redirect_to(users_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the user and re-renders the edit template' do
        patch :update, params: { id: user.id, user: { name: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET #p5_balance' do
    it 'assigns @user and renders the p5_balance template' do
      get :p5_balance, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
      expect(response).to render_template(:p5_balance)
    end
  end
end
