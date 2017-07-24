class UsersController < ApplicationController
  before_action :load_user, except: [:create, :index]
  before_action :authorize_user, except: [:create, :index]

  def create
    @new_user = User.new(user_params)

    if @new_user.save
      render json: @user
    else
      render json: @user.errors
    end
  end

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors
    end
  end

  def destroy
    @user.destroy
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
    # TODO
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def current_user
    # TODO
  end
end
