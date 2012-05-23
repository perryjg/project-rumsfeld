class StatusesController < ApplicationController
  def new
  	@user = current_user
  	@request = @user.requests.find(params[:request_id])
  	@status = @request.statuses.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status }
    end
  end

  def create
    @user = current_user
    @request = @user.requests.find(params[:request_id])
    @status = @request.statuses.new(params[:status])

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Status was successfully updated.' }
        format.json { render json: @request, status: :created, location: @request }
      else
        format.html { render action: "new" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end
end
