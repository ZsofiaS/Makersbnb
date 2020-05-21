def validate_signup(params)
  if params[:username].empty?
    flash[:notice] = "Please enter your username"
    return false
  end
  if params[:name].empty?
    flash[:notice] = "Please enter your name"
    return false
  end
  if params[:email].empty?
    flash[:notice] = "Please enter your email address"
    return false
  end
  if params[:password].empty?
    flash[:notice] = "Please enter a password"
    return false
  end
  return true
end

def persist_form
  flash[:username] = params[:username]
  flash[:name] = params[:name]
  flash[:email] = params[:email]
  flash[:password] = params[:password]
end
