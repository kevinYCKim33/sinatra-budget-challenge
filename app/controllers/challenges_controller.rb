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

  get '/challenges/new' do
    if logged_in?
      erb :"challenges/new_challenge"
    else
      flash[:message] = "Please log in first to create a challenge."
      redirect to "/login"
    end
  end

  post '/challenges' do
    @challenge = Challenge.create(user_id: session[:user_id], name: params[:name], budget: params[:budget])
    redirect to "/challenges/#{@challenge.slug}"
  end

  get '/challenges/:slug' do
    if logged_in?
      @challenge = Challenge.find_by_slug(params[:slug])
      if @challenge.user_id == session[:user_id]
        erb :"challenges/challenge"
      else
        flash[:message] = "You're only allowed to view your own challenge."
        redirect to "/challenges"
      end
    else
      flash[:message] = "Please log in to view your challenge."
      redirect to "/login"
    end
  end
end
