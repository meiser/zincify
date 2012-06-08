class TraversesController < ApplicationController
  # GET /traverses
  # GET /traverses.json
  def index
    @traverses = Traverse.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @traverses }
    end
  end

  # GET /traverses/1
  # GET /traverses/1.json
  def show
    @traverse = Traverse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @traverse }
    end
  end

  # GET /traverses/new
  # GET /traverses/new.json
  def new
    @traverse = Traverse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @traverse }
    end
  end

  # GET /traverses/1/edit
  def edit
    @traverse = Traverse.find(params[:id])
  end

  # POST /traverses
  # POST /traverses.json
  def create
    @traverse = Traverse.new(params[:traverse])

    respond_to do |format|
      if @traverse.save
        format.html { redirect_to @traverse, notice: 'Traverse was successfully created.' }
        format.json { render json: @traverse, status: :created, location: @traverse }
      else
        format.html { render action: "new" }
        format.json { render json: @traverse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /traverses/1
  # PUT /traverses/1.json
  def update
    @traverse = Traverse.find(params[:id])

    respond_to do |format|
      if @traverse.update_attributes(params[:traverse])
        format.html { redirect_to @traverse, notice: 'Traverse was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @traverse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /traverses/1
  # DELETE /traverses/1.json
  def destroy
    @traverse = Traverse.find(params[:id])
    @traverse.destroy

    respond_to do |format|
      format.html { redirect_to traverses_url }
      format.json { head :no_content }
    end
  end



  def fill


  end


end

