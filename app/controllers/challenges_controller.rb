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

  get '/challenges/:slug/edit' do
    if logged_in?
      @challenge = Challenge.find_by_slug(params[:slug])
      if @challenge.user_id == session[:user_id]
        erb :"challenges/edit_challenge"
      else
        flash[:message] = "You're only allowed to edit your own challenge."
        redirect to "/challenges"
      end
    else
      flash[:message] = "Please log in to edit your challenges."
      redirect to "/login"
    end
  end

  get '/challenges/:slug/new_log' do
    if logged_in?
      @challenge = Challenge.find_by_slug(params[:slug])
      if @challenge.user_id == session[:user_id]
        @challenge_slug = params[:slug]
        erb :"logs/new_log"
      else
        flash[:message] = "You're only allowed to log from your own challenge."
        redirect to "/challenges"
      end
    else
      flash[:message] = "Please log in to create a new log."
      redirect to "/login"
    end
  end

  patch '/challenges/:slug' do
    # binding.pry
    @challenge = Challenge.find_by_slug(params[:slug])
    @challenge.name = params[:name]
    @challenge.budget = params[:budget]
    @challenge.save
    flash[:message] = "Your challenge has been sucessfully updated."
    redirect to "/challenges/#{@challenge.slug}"

  end

  delete '/challenges/:slug/delete' do
    if session[:user_id] #if you're a member of budgetchallenge...
      @challenge = Challenge.find_by_slug(params[:slug])
      @user = @challenge.user
      if @user.id == session[:user_id]
        @challenge.destroy
        flash[:message] = "The challenge has been deleted."
      else
        flash[:message] = "Please don't delete a challenge what isn't yours."
      end
    else
      flash[:message] = "Please login if you're trying to delete a challenge."
    end
    redirect "/challenges"
  end

end
