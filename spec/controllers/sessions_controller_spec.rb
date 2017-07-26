require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}

  context 'create' do
    it 'writes user id to session' do
      post :create, params: {id: user.id, password: user.password, username: user.username}
      response_hash = JSON.parse(response.body)

      expect(session[:user_id]).to eq user.id
      expect(response_hash["answer"]).to eq "you have successfully logged in"
    end

    it 'does not authenticate user with wrong password' do
      post :create, params: {id: user.id, password: 'wrong_password', username: user.username}
      response_hash = JSON.parse(response.body)

      expect(session[:user_id]).to eq nil
      expect(response_hash["answer"]).to eq "wrong password or username"
    end

    it 'does not authenticate user with wrong username' do
      post :create, params: {id: user.id, password: user.password, username: 'wrong_username'}
      response_hash = JSON.parse(response.body)

      expect(session[:user_id]).to eq nil
      expect(response_hash["answer"]).to eq "wrong password or username"
    end
  end

  context 'destroy' do
    it 'deletes user id from session' do
      delete :destroy, params: {id: user.id}
      response_hash = JSON.parse(response.body)

      expect(session[:user_id]).to eq nil
      expect(response_hash["answer"]).to eq "you have successfully logged out"
    end

    it 'deletes user id from session after deleting user' do
      session[:user_id] = user.id

      delete :destroy, controller: :user, params: {id: user.id}

      expect(session[:user_id]).to eq nil
    end
  end
end
