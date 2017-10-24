class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  has_secure_password
  has_many :challenges
  has_many :logs

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
end
