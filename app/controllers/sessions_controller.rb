class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:username], params[:password])

    if user.present?
      session[:user_id] = user.id
      render json: {answer: 'you have successfully logged in', user_id: session[:user_id]}, status: 200
    else
      render json: {answer: 'wrong password or username'}, status: 200
    end
  end

  def destroy
    session[:user_id] = nil
    render json: {answer: 'you have successfully logged out'}, status: 200
  end
end
