class ChallengeLog < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :log
end
