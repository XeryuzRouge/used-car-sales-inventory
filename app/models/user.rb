class User < ApplicationRecord
  validates :username, :role, presence: true
  has_secure_password
end
