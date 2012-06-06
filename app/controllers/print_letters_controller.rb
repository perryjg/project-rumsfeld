class PrintLettersController < ApplicationController
  def show
  	@request = Request.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @request_types }
      format.pdf  {
      	render pdf: "letter_#{@request.id}",
      	       margin: { top: 20, bottom: 20, left: 25, right: 25 }
      }
    end
  end
end
