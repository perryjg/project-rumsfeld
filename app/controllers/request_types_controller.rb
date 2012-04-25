class RequestTypesController < ApplicationController
  # GET /request_types
  # GET /request_types.json
  def index
    @request_types = RequestType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @request_types }
    end
  end

  # GET /request_types/1
  # GET /request_types/1.json
  def show
    @request_type = RequestType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @request_type }
    end
  end

  # GET /request_types/new
  # GET /request_types/new.json
  def new
    @request_type = RequestType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @request_type }
    end
  end

  # GET /request_types/1/edit
  def edit
    @request_type = RequestType.find(params[:id])
  end

  # POST /request_types
  # POST /request_types.json
  def create
    @request_type = RequestType.new(params[:request_type])

    respond_to do |format|
      if @request_type.save
        format.html { redirect_to @request_type, notice: 'Request type was successfully created.' }
        format.json { render json: @request_type, status: :created, location: @request_type }
      else
        format.html { render action: "new" }
        format.json { render json: @request_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /request_types/1
  # PUT /request_types/1.json
  def update
    @request_type = RequestType.find(params[:id])

    respond_to do |format|
      if @request_type.update_attributes(params[:request_type])
        format.html { redirect_to @request_type, notice: 'Request type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @request_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_types/1
  # DELETE /request_types/1.json
  def destroy
    @request_type = RequestType.find(params[:id])
    @request_type.destroy

    respond_to do |format|
      format.html { redirect_to request_types_url }
      format.json { head :no_content }
    end
  end
end
