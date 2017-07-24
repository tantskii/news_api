class User < ApplicationRecord
  has_many :news

  validates :username, :password, presence: true
  validates :username, uniqueness: true

  def self.authenticate(username, password)
    user = User.find_by_username(username)

    return user if user.present? && user.password == password

    nil
  end
end
