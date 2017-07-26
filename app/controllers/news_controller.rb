class NewsController < ApplicationController
  before_action :load_news, except: [:index, :create]
  before_action :reject_unauthorized, only: :create
  before_action :authorize_user, only: [:update, :destroy]

  def create
    @new_news = News.new(news_params)
    @new_news[:user_id] = current_user.id

    if @new_news.save
      render json: @new_news
    else
      render json: @new_news.errors
    end
  end

  def show
    render json: @news
  end

  def update
    if @news.update(news_params)
      render json: @news
    else
      render json: @news.errors
    end
  end

  def destroy
    @news.destroy
    raise @news.errors[:base].to_s unless @news.errors[:base].empty?
    render json: {success: true}, status: 200
  end

  def index
    @news_all = News.ordered_by_date(News.all)

    render json: @news_all
  end

  private

  def news_params
    news_params = {}
    news_keys   = [:datetime, :сontent, :sources, :title]

    news_keys.each do |key|
      news_params[key] = params[key] if params[key]
    end

    news_params
  end

  def load_news
    @news ||= News.find params[:id]
  end

  def reject_unauthorized
    unless current_user
      render json: {answer: 'you need to authorize to create news'}
    end
  end

  def authorize_user
    render json: {answer: 'you do not have the right to do this'} unless current_user == @news.user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
