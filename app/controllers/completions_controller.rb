class CompletionsController < ApplicationController
  
  # GET /completions
  # GET /completions.json
  def index
    @completions = Completion.order("created_at desc").page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @completions }
    end
  end

  # GET /completions/1
  # GET /completions/1.json
  def show
    @completion = Completion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @completion }
    end
  end

  # GET /completions/new
  # GET /completions/new.json
  def new
    @completion = Completion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @completion }
    end
  end

  # GET /completions/1/edit
  def edit
    @completion = Completion.find(params[:id])
  end

  # POST /completions
  # POST /completions.json
  def create
   
   #begin
    s =TCPSocket.new("150.101.123.45",8000)
	s.puts '<FP>'
	line = s.gets
	File.open(Rails.root.join('waage.txt'), 'a+') do |f|
	 f.puts line
	end
	weight_regex = /(\d+)(?!.*\d)/
	weight=line.match(weight_regex)
	
	p weight.to_s.to_i
   #rescue
   
   #end

    @completion = Completion.new(params[:completion])
    @completion.user = current_user

    respond_to do |format|
      if @completion.save
        format.html {
          flash[:notice] = "Fertigmeldung #{@completion.ref} wurde angelegt."
          redirect_to new_completion_path
        }
        format.json { render json: @completion, status: :created, location: @completion }
      else
        format.html { render :action => :new }

        format.json { render json: @completion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /completions/1
  # PUT /completions/1.json
  def update
    @completion = Completion.find(params[:id])

    respond_to do |format|
      if @completion.update_attributes(params[:completion])
        format.html { redirect_to @completion, notice: 'Completion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @completion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /completions/1
  # DELETE /completions/1.json
  def destroy
    @completion = Completion.find(params[:id])
    @completion.destroy

    respond_to do |format|
      format.html { redirect_to completions_url }
      format.json { head :no_content }
    end
  end
end

