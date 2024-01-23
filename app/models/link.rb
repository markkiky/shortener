class Link < ApplicationRecord
  belongs_to :user
  validates :url, presence: true
  validates :expiry_date, presence: true
end
