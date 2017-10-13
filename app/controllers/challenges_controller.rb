class ChallengesController < ApplicationController

  get '/challenges' do
    if logged_in?
      @challenges = current_user.challenges
      erb :"challenges/challenge_index"
    else
      flash[:message] = "Please log in first to view your budget challenges."
      redirect to "/login"
    end
  end

  get '/challenges/:slug' do
    @challenge = Challenge.find_by_slug(params[:slug])
    erb :"challenges/challenge"
  end
end
