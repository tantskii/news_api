require 'rails_helper'

RSpec.describe News, type: :model do
  context 'validation check' do
    it { should validate_presence_of :datetime }
    it { should validate_presence_of :сontent }
    it { should validate_presence_of :title }
    it { should validate_presence_of :sources }
  end

  context 'fill_in_date' do
    news = FactoryGirl.create(:news, datetime: '2017-07-25 09:37:03')

    it 'fills date field' do
      expect(news.date.to_s).to eq '2017-07-25'
    end
  end
end
