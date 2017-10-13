class Log < ActiveRecord::Base
  has_many :challenge_logs
  has_many :challenges, through: :challenge_logs
end
