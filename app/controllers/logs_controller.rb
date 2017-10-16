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

  get '/logs/:id/edit' do
    if logged_in?
      @log = Log.find(params[:id])
      if @log.user_id == session[:user_id]
        erb :"logs/edit_log"
      else
        flash[:message] = "You're only allowed to edit your own log."
        redirect to "/logs"
      end
    else
      flash[:message] = "Please log in first to edit a log."
      redirect to "/login"
    end
  end

  patch '/logs/:id' do
    @log = Log.find(params[:id])
    if params[:log][:cost].to_f <= 0 #if you put in a negative $ value...
      flash[:message] = "Please enter a cost amount greater than $0.00"
      redirect to "/logs/#{@log.id}/edit"
    else #you input a positive $ value
      @log.description = params[:log][:description]
      @log.cost = params[:log][:cost].to_f
      @log.challenge_ids = params[:log][:challenge_ids]
      if !params[:challenge][:name].empty? && !params[:challenge][:budget].empty?
        #^^^ if both of these fields aren't empty...
        if params[:challenge][:budget].to_f <= 0
          flash[:message] = "Please enter a budget amount greater than $0.00"
          redirect to "logs/#{@log.id}/edit"
        end

        challenge = Challenge.new(params[:challenge])
        challenge.user_id = session[:user_id]
        challenge.save
        @log.challenges << challenge
      end
      if @log.challenges.empty?
        flash[:message] = "Please select/create a budget challenge this log belongs to."
        redirect to "logs/#{@log.id}/edit"
      end
      @log.save
      flash[:message] = "Your log was sucessfully updated"
      redirect to "/logs/#{@log.id}"
    end
  end

  delete '/logs/:id/delete' do
    if session[:user_id] #if you're a member of budgetchallenge...
      @log = Log.find(params[:id])
      @user = @log.user
      if @user.id == session[:user_id]
        @log.destroy
        flash[:message] = "The log has been deleted."
      else
        flash[:message] = "Please don't delete a log what isn't yours."
      end
    else
      flash[:message] = "Please login if you're trying to delete a log."
    end
    redirect "/logs"
  end

end
