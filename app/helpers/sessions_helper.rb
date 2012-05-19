module SessionsHelper
  
  def signin(user)
    session[:user_id] = user.id
  end
end
