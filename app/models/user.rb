class User < ApplicationRecord

  EMAIL_VALIDATION = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  has_many :events

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :email, uniqueness: true
  validates :email, format: EMAIL_VALIDATION
end
