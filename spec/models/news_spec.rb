require 'rails_helper'

RSpec.describe News, type: :model do
  context 'validation check' do
    it {should validate_presence_of :datetime}
    it {should validate_presence_of :content}
    it {should validate_presence_of :title}
    it {should validate_presence_of :sources}
    it {should validate_length_of :title}
  end

  context 'fill_in_date' do
    news = FactoryGirl.create(:news, datetime: '2017-07-25 09:37:03')

    it 'fills date field' do
      expect(news.date.to_s).to eq '2017-07-25'
    end
  end

  context '.ordered_by_date' do
    FactoryGirl.create(:news, datetime: '2017-05-25 09:37:03')
    FactoryGirl.create(:news, datetime: '2017-04-25 09:37:03')
    FactoryGirl.create(:news, datetime: '2016-04-25 09:37:03')
    FactoryGirl.create(:news, datetime: '2016-04-21 09:37:03')

    it 'sorts news by date' do
      dates = %w(2016-04-21 2016-04-25 2017-04-25 2017-05-25)

      last_news = News.last(4)

      result         = News.ordered_by_date(last_news).map(&:date).each(&:to_s)
      expected_dates = dates.map {|date| Date.parse(date)}

      expect(result).to eq expected_dates
    end
  end
end
