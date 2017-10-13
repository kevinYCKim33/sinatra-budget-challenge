class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :"users/signup"
    else
      flash[:message] = "Already logged in."
      redirect to "/challenges"
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] ="Please fill out all the forms."
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/challenges'
    end
  end

  get '/login' do
    if !logged_in?
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
