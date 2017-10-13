class Challenge < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
  belongs_to :user
  has_many :challenge_logs
  has_many :logs, through: :challenge_logs

  def remaining_budget
    
  end
end
