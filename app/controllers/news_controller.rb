class NewsController < ApplicationController
  before_action :load_news, except: [:index, :create]
  before_action :authorize_user, only: [:create, :update, :destroy]

  def index
    @news_all = News.all

    render json: @news_all
  end

  def show
    render json: @news
  end

  def create
    @new_news = News.new(news_params)
    @new_news[:user_id] = current_user.id

    if @new_news.save
      render json: @new_news
    else
      render json: @new_news.errors
    end
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

  def authorize_user
    # TODO
  end

  def current_user
    # TODO
  end
end
