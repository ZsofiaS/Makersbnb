require 'sinatra'
require 'money'
require './lib/space'
require './lib/booking'
require './lib/user'
require './lib/number_converter'
require './currency_config.rb'
require './database_connection_setup'
require 'sinatra/flash'

class SpacedOut < Sinatra::Base
  use Rack::Session::Pool
  register Sinatra::Flash

  get '/' do
    !session[:user] ? (redirect '/users/log-in') : (redirect '/spaces')
  end

  get '/users/new' do
    session[:user] = nil
    erb :'users/new'
  end

  post '/users/new' do
    if User.create(params[:username], params[:name], params[:email], params[:password])
      redirect '/users/log-in'
    else
      flash[:notice] = "Email or username already taken"
      redirect '/users/new'
    end
  end

  get '/users/log-in' do
    session[:user] ? (redirect '/spaces') : (erb :'users/login')
  end

  post '/users/log-in' do
    session[:user] = User.authenticate(params[:username], params[:password])
    if session[:user] == nil
      flash[:notice] = "Username or password is incorrect"
      redirect('/users/log-in')
    else
      redirect('/spaces')
    end
  end

  get '/signout' do
    session[:user] = nil
    redirect '/users/log-in'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces/new' do
    path = ''
    if params[:image] && params[:image][:filename]
      filename = params[:image][:filename]
      file = params[:image][:tempfile]
      path = "./public/uploads/#{filename}"

      # Write file to disk
      File.open(path, 'wb') do |f|
        f.write(file.read)
      end
    end
    path = "uploads/#{filename}"

    Space.new(
      nil,
      params[:name],
      params[:description],
      Money.new(NumberConverter.two_decimal_place_float_to_int(params[:price_per_night].to_f)),
      Date.parse(params[:available_from]),
      Date.parse(params[:available_to]),
      path
    ).save

    redirect('/spaces')
  end

  get '/spaces' do
    @spaces = Space.all
    erb:'spaces/index'
  end

  get '/spaces/:id' do
    @date_invalid = session[:notice]
    erb :'bookings/booking'
  end

  post '/spaces/:id' do
    @user = session[:user]
    @space = Space.find(params[:id])

    if (params[:booking_date] == "")
      session[:notice] = "Please enter a valid date"
      redirect '/spaces/1'
    end

    @booking_date = Date.parse(params[:booking_date])
    @booking = Booking.create(space_id: @space.id, user_id: @user.id, date: @booking_date)
    redirect '/requests/users/'"#{@booking.user_id}"
  end

  get '/requests/users/:id' do
    @booking = Booking.find(user_id: params[:id])
    erb :'bookings/requests'
  end

  get '/requests/spaces/:id' do
    erb :'bookings/spaces'
  end

  get '/upload' do
    erb :'upload'
  end

  post '/upload' do
      # Check if user uploaded a file
    if params[:image] && params[:image][:filename]
      filename = params[:image][:filename]
      file = params[:image][:tempfile]
      path = "./public/uploads/#{filename}"

      # Write file to disk
      File.open(path, 'wb') do |f|
        f.write(file.read)
      end
    end
  end
end
