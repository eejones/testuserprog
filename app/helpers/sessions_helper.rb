module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user  
    #The purpose of this line is to create current_user, accessible in both controllers and views, which will allow constructions such as <%= current_user.name %>
    #The use of self is necessary in this context for the same essential reason noted in the discussion leading up to Listing 8.18: without self, Ruby would simply create a local variable called current_user.
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    # 'self.current_user = ...' is automatically converted to 'current_user=(...)'
    @current_user=user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
   # without this method, the user’s signin status would be forgotten: as soon as the user went to another page—poof!—the session would end and the user would be automatically signed out. To avoid this problem, we can find the user corresponding to the remember token created by the sign_in method above
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end


  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
