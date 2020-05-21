def validate_signup(params)
  if params[:username].empty?
    flash[:notice] = "Please enter your username"
    redirect '/users/new'
  end
  if params[:name].empty?
    flash[:notice] = "Please enter your name"
    redirect '/users/new'
  end
  if params[:email].empty?
    flash[:notice] = "Please enter your email address"
    redirect '/users/new'
  end
  if params[:password].empty?
    flash[:notice] = "Please enter a password"
    redirect '/users/new'
  end
end
