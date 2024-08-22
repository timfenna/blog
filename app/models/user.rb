class User < ApplicationRecord
  include Clearance::User

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, presence: true, uniqueness: true
end
