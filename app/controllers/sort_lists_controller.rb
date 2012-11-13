class SortListsController < ApplicationController
  # GET /sort_lists
  # GET /sort_lists.json
  def index
    @sort_lists = SortList.order("created_at asc").page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
	  format.js
      format.json { render json: @sort_lists }
    end
  end

  # GET /sort_lists/1
  # GET /sort_lists/1.json
  def show
    @sort_list = SortList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sort_list }
    end
  end

  # GET /sort_lists/new
  # GET /sort_lists/new.json
  def new
    @sort_list = SortList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sort_list }
    end
  end

  # GET /sort_lists/1/edit
  def edit
    @sort_list = SortList.find(params[:id])
  end

  # POST /sort_lists
  # POST /sort_lists.json
  def create
    @sort_list = SortList.new(params[:sort_list])

    respond_to do |format|
      if @sort_list.save
        format.html { redirect_to sort_lists_path, notice: "Sortenverzeichniseintrag #{@sort_list.number} (#{@sort_list.description}) wurde erstellt." }
        format.json { render json: @sort_list, status: :created, location: @sort_list }
      else
        format.html { render action: "new" }
        format.json { render json: @sort_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sort_lists/1
  # PUT /sort_lists/1.json
  def update
    @sort_list = SortList.find(params[:id])

    respond_to do |format|
      if @sort_list.update_attributes(params[:sort_list])
        format.html { redirect_to sort_lists_path, notice: "Sortenverzeichniseintrag #{@sort_list.number} (#{@sort_list.description}) wurde aktualisiert." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sort_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sort_lists/1
  # DELETE /sort_lists/1.json
  def destroy
    @sort_list = SortList.find(params[:id])
    @sort_list.destroy

    respond_to do |format|
      format.html { redirect_to sort_lists_url }
      format.json { head :no_content }
    end
  end
end
