require 'date'
class Log < ActiveRecord::Base
  has_many :challenge_logs
  has_many :challenges, through: :challenge_logs
  belongs_to :user

  def date_logged
    (self.created_at - 25200).strftime("%A, %B %d, %Y %I:%M %p")
  end
end
