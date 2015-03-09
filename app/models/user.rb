class User < ActiveRecord::Base
  validates :email, :name, presence: true
  validates :email, uniqueness: true
end
