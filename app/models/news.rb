class News < ApplicationRecord
  belongs_to :user

  validates :datetime, :content, :title, :sources, :user, presence: true, on: :create
  # TODO validates :datetime, :content, :sources, uniqueness: true

  serialize :sources, Array

  before_save :fill_in_date

  def self.ordered_by_date(news)
    news.sort { |first_news, second_news| first_news.date <=> second_news.date }
  end

  private

  def fill_in_date
    self.date = datetime.to_date
  end
end
