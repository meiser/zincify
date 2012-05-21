class SessionsController < ApplicationController

  skip_before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @dialog = true
    @user = User.new
  end

  def create
    #reset_session
    user = User.ldap_auth(params[:user][:login_or_email], params[:user][:password])
    if user
      user.sign_in_count ||= 0
      user.sign_in_count += 1

      old_current, new_current = user.current_sign_in_at, Time.now.utc
      user.last_sign_in_at = old_current || new_current
      user.current_sign_in_at = new_current

      old_current, new_current = user.current_sign_in_ip, request.ip
      user.last_sign_in_ip = old_current || new_current
      user.current_sign_in_ip = new_current

      user.save(:validate => false)
      session[:user_id] = user.id
      #path = session[:return_to] || "/dashboard"

      redirect_to "/dashboard", :notice => t(".signed_in", :scope => :authentification)
    else
      flash[:error] = t(".invalid", :scope => :authentification)
      @dialog = true
      p "skeller########################################"
      p params
      redirect_to :action => :new
    end
  end

  def destroy
    user = User.find_by_id(session[:user_id])
    session[:user_id] = nil
    session[:return_to] = nil
    flash[:notice] = t(".signed_out", :scope => :authentification)
    redirect_to root_url
  end
end

