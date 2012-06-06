class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
  end

  def edit
    @user = current_user
    @printers = Printer.all
    @user.default_printer = @user.preferences.default_printer
  end

  def update
    @user = current_user
    @user.preferences.default_printer = params[:user][:default_printer]
   respond_to do |format|
     if @user.save
       format.html { redirect_to dashboard_path, notice: 'Nutzereinstellungen aktualisiert' }
       format.mobile { redirect_to dashboard_path, notice: 'Nutzereinstellungen aktualisiert' }
       format.json { head :no_content }
     else
       format.html { render action: "edit" }
       format.mobile { render action: "edit" }
       format.json { render json: @user.errors, status: :unprocessable_entity }
     end
    end
  end

end

