class PrintLettersController < ApplicationController
  def show
  	@request = Request.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @request_types }
      format.pdf  { render pdf: "letter_#{@request.id}" }
    end
  end
end
