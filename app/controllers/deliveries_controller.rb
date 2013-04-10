class DeliveriesController < ApplicationController

  # GET /deliveries
  # GET /deliveries.json
  
  
  respond_to :json, :only => :print

  before_filter :get_printer
  before_filter :get_customer_from_bpid, :only => [:create,:update]

  def index
    respond_to do |format|
	  format.html
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
	@delivery.indate = Time.now.strftime("%d.%m.%Y")
	@delivery.outdate = (@delivery.indate+1.days).strftime("%d.%m.%Y")
    @delivery.deliver_references.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @delivery }
    end
  end

  # GET /deliveries/1/edit
  def edit
    @delivery = Delivery.find(params[:id])
	@delivery.customer_bpid= @delivery.customer.bpid
  end

  # POST /deliveries
  # POST /deliveries.json
  def create
	@delivery = Delivery.new(params[:delivery])
	
	respond_to do |format|
      if @delivery.save
        format.html { redirect_to @delivery, notice: t("deliveries.created") }
        format.json { render json: @delivery, status: :created, location: @delivery }
      else
        format.html { render action: "new" }
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
		format.html { redirect_to @delivery, notice: t("deliveries.updated") }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
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
      format.html { redirect_to deliveries_url }
      format.json { head :no_content }
    end
  end
  
  
  
  def received
	Delivery.find(:all,)
  
  end
  

  def print
	@delivery = Delivery.find(params[:data].first[:id])
    t = PrintTrigger.new
	t.printer = current_user.preferences.default_printer
	t.label = "commission.btw"
	t.data = "#{@delivery.commission}|#{@delivery.customer.name}|#{@delivery.cash_payer? ? [@delivery.customer.name.upcase,@delivery.cash_payer.search_string].join(": ") : [@delivery.customer.name,@delivery.customer.address].join(" ")}|#{l(@delivery.indate)}|#{l(@delivery.outdate)}|#{@delivery.remarks}"
	t.save
	
	data={
		:title => 'Etikett drucken',
		:message => 'Druckauftrag erfolgreich erstellt',
		:success => true
	}

	puts @data.to_json
	
	render :json => data
  end

  private


  def get_customer_from_bpid
	c = Customer.find_by_bpid(params[:delivery].delete :customer_bpid)
	params[:delivery][:cash_payer_id]=nil if c.bpid != "280000142"
	params[:delivery][:customer] = c
  end
  
  def get_printer
    @printers = Printer.all
  end



end

