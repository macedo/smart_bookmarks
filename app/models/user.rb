class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable

  devise :database_authenticatable, :trackable, :validatable

  has_many :bookmarks, dependent: :destroy

  class << self
    def authenticate(email, password)
      user = User.find_for_authentication(email: email)
      user&.valid_password?(password) ? user : nil
    end
  end

  def username
    email.split("@").first
  end
end
