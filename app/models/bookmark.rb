class Bookmark < ApplicationRecord
  validates :link,
    presence: true,
    uri: true

  validates :name,
    presence: true
end
