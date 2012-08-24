class DeliveriesController < ApplicationController

  # GET /deliveries
  # GET /deliveries.json


  before_filter :get_printer


  def index
    @deliveries = Delivery.order("created_at desc").page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deliveries }
    end
  end

  # GET /deliveries/1
  # GET /deliveries/1.json
  def show
    @delivery = Delivery.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @delivery }
    end
  end

  # GET /deliveries/new
  # GET /deliveries/new.json
  def new
    @delivery = Delivery.new
    @delivery.deliver_references.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @delivery }
    end
  end

  # GET /deliveries/1/edit
  def edit
    @delivery = Delivery.find(params[:id])
  end

  # POST /deliveries
  # POST /deliveries.json
  def create
    @delivery = Delivery.new(params[:delivery])

    respond_to do |format|
      if @delivery.save
        format.mobile { redirect_to deliveries_path, notice: t("deliveries.created") }
        format.json { render json: @delivery, status: :created, location: @delivery }
      else
        format.mobile { render action: "new" }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /deliveries/1
  # PUT /deliveries/1.json
  def update
    @delivery = Delivery.find(params[:id])

    respond_to do |format|
      if @delivery.update_attributes(params[:delivery])
        #render :text => "mike"
        format.mobile { redirect_to @delivery, notice: t("deliveries.updated") }
        format.json { head :no_content }
      else
        format.mobile { render action: "edit" }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.json
  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy

    respond_to do |format|
      format.mobile { redirect_to deliveries_url }
      format.json { head :no_content }
    end
  end

   def print
    @delivery = Delivery.find(params[:id])
    p @delivery
#zpl_code3 = <<END_OF_STRING
# <?xml version="1.0" standalone="no" ?>
#<!DOCTYPE labels SYSTEM "label.dtd">
#<labels _FORMAT="E:TESTZEBR.ZPL">
#<label>
#<variable name="commission">#{@delivery.commission}</variable>
#<variable name="annahme">#{l @delivery.indate, :format => :long}</variable>
#<variable name="abgabe">#{l(@delivery.outdate,:format => :long)}</variable>
#<variable name="customer">#{@delivery.customer.name}</variable>
#</label>
#</labels>
#END_OF_STRING

#    Socket.tcp('150.101.5.99','9100'){|sock|
#      sock.print zpl_code3
#      sock.close_write
#    }

    file_name = SecureRandom.hex(10)
    local_file_dir = Rails.root.join("public","etiketten")
    local_file =  local_file_dir.join("#{file_name}.ctg")

    FileUtils.mkpath(local_file_dir)
    File.open(local_file, 'w') do |f|
        f.puts("#{current_user.preferences.default_printer}|commission.btw|#{@delivery.commission}|#{@delivery.customer.name}|#{l(@delivery.indate, :format => :long)}|#{l(@delivery.outdate, :format => :long)}|#{@delivery.remarks}")
    end


    render :js => "alert('Fertig');"
  end

  private


  def get_printer
    @printers = Printer.all
  end



end

