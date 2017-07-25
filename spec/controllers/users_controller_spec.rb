require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:another_user) {FactoryGirl.create(:user)}

  context 'create' do
    it 'creates user' do
      password = rand(1000...9999).to_s
      username = "usr#{rand(1000)}"
      number_of_users_before = User.all.count

      post :create, params: {password: password, username: username}
      response_hash = JSON.parse(response.body)

      expect(response.status).to eq 200

      response_password = response_hash['password']
      response_username = response_hash['username']
      number_of_users_after = User.all.count

      expect(response_password).to eq password
      expect(response_username).to eq username
      expect(number_of_users_after).to eq number_of_users_before + 1
    end
  end

  context 'update' do
    it 'does not update unauthorized user' do
      put :update, params: {id: user.id, password: '12345'}
      response_hash = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response_hash["answer"]).to eq "you do not have the right to do this"
    end

    it 'can not update another user' do
      session[:user_id] = user.id

      put :update, params: {id: another_user.id, username: 'new_username'}
      response_hash = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response_hash["answer"]).to eq "you do not have the right to do this"
    end

    it 'updates authorized user' do
      session[:user_id] = user.id

      new_password = rand(1000...9999).to_s

      put :update, params: {id: user.id, password: new_password}
      response_hash = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response_hash['password']).to eq new_password
    end
  end

  context 'delete' do
    it 'does not delete unauthorized user' do
      delete :destroy, params: {id: user.id}
      response_hash = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response_hash["answer"]).to eq "you do not have the right to do this"
    end

    it 'can not delete another user' do
      session[:user_id] = user.id

      delete :destroy, params: {id: another_user.id}
      response_hash = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response_hash["answer"]).to eq "you do not have the right to do this"
    end

    it 'deletes unauthorized user' do
      session[:user_id] = user.id

      delete :destroy, params: {id: user.id}
      response_hash = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response_hash["success"]).to be_truthy
    end
  end
end
