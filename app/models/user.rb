class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable

  devise :database_authenticatable, :trackable, :validatable

  has_many :bookmarks, dependent: :destroy

  def username
    email.split("@").first
  end
end
