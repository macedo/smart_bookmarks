class Bookmark < ApplicationRecord
  validates :link,
    presence: true,
    uri: true

  validates :name,
    presence: true

  scope :ordered, ->{ order(created_at: :desc) }

  broadcasts_to ->(bookmark) { "bookmarks" }, inserts_by: :prepend
end
