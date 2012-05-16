class SessionsController < ApplicationController

  skip_before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    reset_session
    user = User.ldap_auth(params[:user][:login_or_email], params[:user][:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash[:notice] = "Invalid login or email or password"
      redirect_to :action => :new
    end
  end

  def destroy
    user = User.find_by_id(session[:user_id])
    p user
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_url
  end
end

