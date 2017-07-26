class UsersController < ApplicationController
  before_action :load_user, except: :create
  before_action :authorize_user, except: :create

  def create
    @new_user = User.new(user_params)

    if @new_user.save
      render json: @new_user
    else
      render json: @new_user.errors, status: 403
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: 403
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil

    raise @user.errors[:base].to_s unless @user.errors[:base].empty?
    render json: {success: true}, status: 200
  end

  private

  def user_params
    user_params = {}
    user_keys   = [:password, :username]

    user_keys.each do |key|
      user_params[key] = params[key] if params[key]
    end

    user_params
  end

  def authorize_user
    unless current_user == @user
      render json: {answer: 'you do not have the right to do this'}, status: 401
    end
  end

  def load_user
    @user ||= User.find params[:id]
  end
end
