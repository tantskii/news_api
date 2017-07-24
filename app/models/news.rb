class News < ApplicationRecord
  belongs_to :user

  validates :datetime, :сontent, :title, :sources, :user, presence: true, on: :create
  # TODO validates :datetime, :сontent, :sources, uniqueness: true

  before_save :fill_in_date

  private

  def fill_in_date
    self.date = datetime.to_date
  end
end
