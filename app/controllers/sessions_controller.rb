class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.authenticate(params[:user][:login_or_email], params[:user][:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash[:notice] = "Invalid login or email or password"
      redirect_to :action => :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Invalid login or email or password"
    redirect_to root_url
  end
end

