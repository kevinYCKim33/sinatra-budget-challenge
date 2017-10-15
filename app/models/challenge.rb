class Challenge < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
  belongs_to :user
  has_many :challenge_logs
  has_many :logs, through: :challenge_logs

  def money_spent
    self.logs.sum(:cost)
  end

  def remaining_budget
    self.budget - money_spent
  end

  def percentage_spent
    (money_spent/self.budget)*100
  end

  def date_started
    (self.created_at - 25200).strftime("%A, %B %d, %Y")
  end
end
