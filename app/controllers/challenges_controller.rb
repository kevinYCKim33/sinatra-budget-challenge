class ChallengesController < ApplicationController
  get '/challenges' do
    if logged_in?
      erb :"challenges/index"
    else
      flash[:message] = "Please log in first to view your budget challenges."
    end
  end
end
