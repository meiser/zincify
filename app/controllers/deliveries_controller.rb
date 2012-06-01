class DeliveriesController < ApplicationController

  autocomplete :customer, :name, :full => true, :display_value => :name_with_address, :extra_data => [:address]

  # GET /deliveries
  # GET /deliveries.json
  def index
    @deliveries = Delivery.all

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
        format.mobile { redirect_to @delivery, notice: 'Delivery was successfully created.' }
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
        format.mobile { redirect_to @delivery, notice: 'Delivery was successfully updated.' }
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
    zpl_code1 = "^XA^F050,50^ADN,36,20^FDKunde: #{@delivery.customer.name}^FS^XZ"
    zpl_code2 = "^XA^F050,50^ADN,36,20^FDDatum: #{@delivery.deadline}^FS^XZ"
    zpl_code3 = "^XA^F050,50^B3R,N, 100,Y^FD Kommission: #{SecureRandom.hex(10)}^FS^XZ"
    zpl_code = zpl_code1+zpl_code2+zpl_code3

    zpl_code3="^XA
^DFE:MEISER1^FS
^PRC
^LH0,0^FS
^MMT
^FO5,30^A0R,70,50^CI13^FR^FB222,2,0,C^FN999^FS
^BY2,3.0^FO460,61^B3R,N,100,Y,N^FR^FN998^FS
^FO288,225^A0R,47,40^CI13^FR^FB103,1,0,C^FN997^FS
^FO270,450^A0R,47,40^CI13^FR^FB689,2,0,L^FN996^FS
^FO214,450^A0R,47,40^CI13^FR^FB689,2,0,L^FN995^FS
^FO158,450^A0R,47,40^CI13^FR^FB689,2,0,L^FN994^FS
^FO103,450^A0R,47,40^CI13^FR^FB689,2,0,L^FN993^FS
^FO47,450^A0R,47,40^CI13^FR^FB689,2,0,L^FN992^FS
^FO5,450^A0R,47,40^CI13^FR^FB689,2,0,L^FN991^FS
^FO288,105^A0R,47,40^CI13^FR^FB103,1,0,C^FN990^FS
^FO627,591^FR^XGE:P7_HNMei,1,1^FS
^FO379,454^A0R,31,25^CI13^FR^FDEmpfaenger^FS
^FO355,104^A0R,31,25^CI13^FR^FDAnzahl der Packstuecke^FS
^FO156,104^A0R,31,25^CI13^FR^FDAuftrag^FS
^FO516,852^A0R,31,25^CI13^FR^FDMeiser Vogtland OHG^FS
^FO485,716^A0R,31,25^CI13^FR^FDAm Lehmteich 3 - 08606 Oelsnitz^FS
^FO454,819^A0R,31,25^CI13^FR^FDTelefon (03 74 21) 50-0^FS
^FO424,696^A0R,31,25^CI13^FR^FDTelefax (Verkauf) (03 74 21) 50-2120^FS
^FO15,440^GB365,703,4^FS
^FO288,104^GB64,232,4^FS
^FO288,214^GB64,0,4^FS
^XZ"


    Socket.tcp('150.101.5.99','9100'){|sock|
     sock.print zpl_code3
     sock.close_write
    }
    render :js => "alert('Fertig');"
  end

end

