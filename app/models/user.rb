class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :cart, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # Fixes logic error where user signs up with already existing account
  validates :email_address, presence: true, uniqueness: true
end
