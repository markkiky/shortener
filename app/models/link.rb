# frozen_string_literal: true

# Link Model
class Link < ApplicationRecord
  belongs_to :user
  validates :url, presence: true
  validates :url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :expiry_date, presence: true
  validate :expiry_date_valid
  validates :short_code, presence: true
  validates :short_code, uniqueness: true
  validates_format_of :short_code, with: /\A[a-zA-Z0-9\-_]+\z/,
                                   message: 'Only letters, numbers, hyphens, and underscores are allowed'
  before_validation :generate_short_code

  def short_url
    Rails.application.routes.url_helpers.short_url(short_code:, host: ENV['HOST'] || 'http://localhost:3000')
  end

  private

  def expiry_date_valid
    errors.add(:expiry_date, 'must be today or in the future') if expiry_date.present? && expiry_date < Date.current
  end

  def generate_short_code
    self.short_code = SecureRandom.uuid[0..5] if short_code.nil? || short_code.empty?
  end
end
