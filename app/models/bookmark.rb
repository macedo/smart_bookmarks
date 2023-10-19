class Bookmark < ApplicationRecord
  validates :link,
    presence: true,
    uri: true

  validates :name,
    presence: true

  scope :ordered, ->{ order(created_at: :desc) }
end
