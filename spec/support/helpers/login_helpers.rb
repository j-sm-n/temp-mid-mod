module LoginHelpers
  def login_user(user)
    session[:user_id] = user.id
  end
end
