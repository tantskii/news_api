class User < ApplicationRecord
  has_many :news

  USERNAME_REGEX = /\A[a-zA-Z0-9_]+\z/

  validates :username, length: {maximum: 20}
  validates :username, format: {with: USERNAME_REGEX}

  validates :username, :password, presence: true
  validates :username, uniqueness: true

  def self.authenticate(username, password)
    user = User.find_by_username(username)

    return user if user.present? && user.password == password

    nil
  end
end
