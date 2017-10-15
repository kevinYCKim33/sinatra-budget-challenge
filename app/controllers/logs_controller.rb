class LogsController < ApplicationController
  get '/logs' do
    if logged_in?
      @logs = current_user.logs
      erb :"logs/logs_index"
    else
      flash[:message] = "Please log in first to view your spending logs."
      redirect to "/login"
    end
  end

  post '/logs' do
    @log = Log.new(params[:log])
    @log.user = current_user
    if @log.cost <= 0
      flash[:message] = "Please enter a cost amount greater than $0.00"
      redirect to "/logs/new"
    else
      if !params[:challenge][:name].empty? && !params[:challenge][:budget].empty?
        if (!params[:challenge][:name].empty? && params[:challenge][:budget].empty?) || (params[:challenge][:name].empty? && !params[:challenge][:budget].empty?)
          flash[:message] = "Please fill out BOTH or NEITHER of the challenge name/target budget forms"
          redirect to "logs/new"
        elsif params[:challenge][:budget].to_f <=0
          flash[:message] = "Please enter a budget amount greater than $0.00"
          redirect to "logs/new"
        end
        challenge = Challenge.new(params[:challenge])
        challenge.user_id = session[:user_id]
        challenge.save
        @log.challenges << challenge
      end
      if @log.challenges.empty?
        flash[:message] = "Please select/create a budget challenge this log belongs to."
        redirect to "logs/new"
      end
      @log.save
      redirect to "/logs"
    end
  end

  get '/logs/new' do
    if logged_in?
      erb :"logs/new_log"
    else
      flash[:message] = "Please log in first to log a spending."
      redirect to "/login"
    end
  end

  get '/logs/:id' do
    if logged_in?
      @log = Log.find(params[:id])
      if @log.user_id == session[:user_id]
        erb :"logs/log"
      else
        flash[:message] = "You're only allowed to view your own log."
        redirect to "/logs"
      end
    else
      flash[:message] = "Please log in first to view a log."
      redirect to "/login"
    end
  end




end
