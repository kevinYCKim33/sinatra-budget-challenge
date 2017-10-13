class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :challenge_logs
  has_many :logs, through: :challenge_logs
end
