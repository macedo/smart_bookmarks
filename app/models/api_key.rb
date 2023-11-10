class ApiKey < ApplicationRecord
  HMAC_SECRET_KEY = Rails.application.credentials.api_key_hmac_secret_key
  TOKEN_NAMESPACE = "k"

  encrypts :random_token_prefix, deterministic: true

  belongs_to :bearer, polymorphic: true

  before_validation :set_common_token_prefix, on: :create
  before_validation :generate_random_token_prefix, on: :create
  before_validation :generate_raw_token, on: :create
  before_validation :generate_token_digest, on: :create

  validates :name, presence: true
  validates :random_token_prefix,
    uniqueness: {
      scope: [:bearer_id, :bearer_type]
    }

  scope :active, -> { where(revoked_at: nil) }

  attr_accessor :raw_token

  def self.generate_digest(token) = OpenSSL::HMAC.hexdigest("SHA256", HMAC_SECRET_KEY, token)

  def token_prefix = "#{common_token_prefix}#{random_token_prefix}"

  private

  def common_token_subprefix = "usr"

  def set_common_token_prefix = self.common_token_prefix = "#{TOKEN_NAMESPACE}_#{common_token_subprefix}_"

  def generate_random_token_prefix = self.random_token_prefix = SecureRandom.base58(6)

  def generate_raw_token = self.raw_token = [common_token_prefix, random_token_prefix, SecureRandom.base58(24)].join("")

  def generate_token_digest = self.token_digest = self.class.generate_digest(raw_token)
end
