class CommissionsController < ApplicationController
  # GET /commissions
  # GET /commissions.json

  before_filter :load_printers

  def index
    @commissions = Commission.last(150).reverse
    respond_to do |format|
      format.html # index.html.erb
      format.mobile
      format.json { render json: @commissions }
    end
  end

  # GET /commissions/1
  # GET /commissions/1.json
  def show
    @commission = Commission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.mobile
      format.json { render json: @commission }
    end
  end

  # GET /commissions/new
  # GET /commissions/new.json
  def new
    @commission = Commission.new

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
      format.json { render json: @commission }
    end
  end

  # GET /commissions/1/edit
  def edit
    @commission = Commission.find(params[:id])
  end

  # POST /commissions
  # POST /commissions.json


  def create
    @commission = Commission.new(params[:commission])

    printer = params[:baan][:printer] || false

    respond_to do |format|
      if @commission.save
        path = Rails.root.join("public","system")
        FileUtils.mkdir_p path
        File.open(Rails.root.join(path,"#{@commission.orno}_#{Time.now}"),"w") do |f|
          f.puts("#{printer}|#{@commission.orno}|#{@commission.appointment}")
        end
        format.html { redirect_to commissions_url, notice: 'Commission was successfully created.' }
        format.mobile { redirect_to @commission, notice: 'Commission was successfully created.'}
        format.json { render json: @commission, status: :created, location: @commission }
      else
        format.html { render action: "new" }
        format.mobile { render action: "new" }
        format.json { render json: @commission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /commissions/1
  # PUT /commissions/1.json
  def update
    @commission = Commission.find(params[:id])

    respond_to do |format|
      if @commission.update_attributes(params[:commission])
        format.html { redirect_to @commission, notice: 'Commission was successfully updated.' }
        format.mobile { redirect_to @commission, notice: 'Commission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.mobile { render action: "edit" }
        format.json { render json: @commission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commissions/1
  # DELETE /commissions/1.json
  def destroy
    @commission = Commission.find(params[:id])
    @commission.destroy

    respond_to do |format|
      format.html { redirect_to commissions_url }
      format.mobile { redirect_to commissions_url }
      format.json { head :no_content }
    end
  end

  private

  def load_printers
   @printers = BAAN_PRINTERS
  end

end

