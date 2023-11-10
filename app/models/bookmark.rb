class Bookmark < ApplicationRecord
  belongs_to :user

  validates :link,
    presence: true,
    uri: true

  validates :name,
    presence: true

  scope :ordered, -> { order(created_at: :desc) }

  broadcasts_to ->(bookmark) { [bookmark.user, "bookmarks"] }, inserts_by: :append
end
