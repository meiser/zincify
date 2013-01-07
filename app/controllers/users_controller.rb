class UsersController < ApplicationController

  def edit
    @user = current_user
    @printers = Printer.all
    @user.default_printer = @user.preferences.default_printer
    session[:return_to] = request.referer
  end

  def update
    @user = current_user
    @user.preferences.default_printer = params[:user][:default_printer]
   respond_to do |format|
     if @user.save
       format.html { redirect_to session[:return_to], notice: 'Nutzereinstellungen aktualisiert' }
       format.json { head :no_content }
     else
       format.html { render action: "edit" }
       format.json { render json: @user.errors, status: :unprocessable_entity }
     end
    end
  end


  def printer
    render :js => params
  end

end