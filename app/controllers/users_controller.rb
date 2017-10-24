class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      @page_title = "BudgetChallenge - Sign Up"
      erb :"users/signup"
    else
      flash[:message] = "Already logged in."
      redirect to "/challenges"
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to '/challenges'
    else
      flash[:message] = @user.errors.full_messages.join(', ')
      redirect to '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      @page_title = "BudgetChallenge - Log In"
      erb :"users/login"
    else
      flash[:message] = "Already logged in."
      redirect '/challenges'
    end
  end

  post '/login' do
    user = User.find_by(:email => params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/challenges"
      else
        flash[:message] = "Incorrect email/password"
        redirect to '/login'
      end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      flash[:message] = "Please sign in or sign up first."
      redirect to '/'
    end
  end

end
