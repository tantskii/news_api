require 'rails_helper'

RSpec.describe NewsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:news) {FactoryGirl.create(:news, user_id: user.id)}

  context 'create' do
    it 'does not create news if user is not authorized' do
      post :create, params: {
          datetime: DateTime.now,
          content:  'Donald Trump on Tuesday condemned Jeff Sessions',
          title:    'politics',
          sources:  %w(bbc NYT guardian)
      }

      expect(response.body).to eq "{\"answer\":\"you need to authorize to create news\"}"
    end

    it 'creates news if user is authorized' do
      session[:user_id]  = user.id
      news_number_before = News.all.count

      post :create, params: {
          datetime: '2017-07-25 09:37:03',
          content:  'Donald Trump on Tuesday condemned Jeff Sessions',
          title:    'politics',
          sources:  %w(bbc NYT guardian)
      }

      news_number_after = News.all.count

      expect(news_number_after).to eq news_number_before + 1
    end
  end

  context 'read' do
    it 'returns all news' do
      get :index

      response_hash = JSON.parse(response.body)
      news_number   = News.all

      expect(news_number.count).to eq response_hash.count
    end

    it 'returns news by id' do
      post :create, params: {
          id:       user.id,
          datetime: '2017-07-25 09:37:03',
          content:  'Donald Trump on Tuesday condemned Jeff Sessions',
          title:    'politics',
          sources:  %w(bbc NYT guardian)
      }

      last_news = News.last

      get :show, params: {id: last_news.id}

      last_news     = last_news.as_json
      response_hash = JSON.parse(response.body)

      expect(response_hash['id']).to eq last_news['id']
      expect(DateTime.parse(response_hash['datetime'])).to eq last_news['datetime']
      expect(response_hash['content']).to eq last_news['content']
      expect(response_hash['title']).to eq last_news['title']
      expect(response_hash['sources']).to eq last_news['sources']
    end
  end

  context 'update' do
    it 'updates news if user is authorized' do
      session[:user_id] = user.id

      expect(news.user_id).to eq user.id

      put :update, params: {id: news.id, title: 'sport'}

      updated_news = News.find(news.id)

      expect(updated_news['title']).to eq 'sport'
    end

    it 'does not update news if user is not authorized' do
      expect(news.user_id).to eq user.id

      put :update, params: {id: news.id, title: 'war'}

      updated_news = News.find(news.id)

      expect(updated_news['title']).to eq 'politics'
    end
  end

  context 'destroy' do
    it 'does not delete news if user is not authorized' do
      expect(news.user_id).to eq user.id

      delete :destroy, params: {id: news.id}

      deleted_news = News.exists?(news.id)

      expect(deleted_news).to be_truthy
    end

    it 'deletes news if user is authorized' do
      session[:user_id] = user.id

      expect(news.user_id).to eq user.id

      delete :destroy, params: {id: news.id}

      deleted_news = News.exists?(news.id)

      expect(deleted_news).to be_falsey
    end
  end
end
