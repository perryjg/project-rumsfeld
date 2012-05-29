class PrintLettersController < ApplicationController
  def show
  	@request = Request.find(params[:id])
  end
end
