class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private

	  def current_user
	    @current_user ||= User.find(session[:user_id]) if session[:user_id]
	  end
	  helper_method :current_user

	  def current_user?(user)
	  	user == current_user
	  end
	  
	  def authorize
	    redirect_to signin_path, alert: "Please sign in" if current_user.nil?
	  end

	  def correct_user
	  	@user = User.find(params[:id])
	    redirect_to root_path, alert: "Not Authorized" unless current_user?(@user)
	  end
end
