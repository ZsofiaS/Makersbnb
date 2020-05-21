require 'sinatra'
require 'money'
require './lib/space'
require './lib/booking'
require './lib/user'
require './lib/number_converter'
require './currency_config.rb'
require './database_connection_setup'
require 'sinatra/flash'
require 'date'

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
    if session[:user].nil?
      flash[:notice] = 'not signed in'
      redirect('/users/log-in')
    end
    erb :'spaces/new'
  end

  post '/spaces/new' do
  
     Space.new(
       nil,
       params[:name],
        params[:description],
        Money.new(NumberConverter.two_decimal_place_float_to_int(params[:price_per_night].to_f)),
        Date.parse(params[:available_from]),
        Date.parse(params[:available_to]),
        session[:user].id
     ).persist
     session[:spaces] = Space.all
     redirect('/spaces')
   end

  get '/spaces' do
    if session[:spaces].nil?
      @spaces = Space.all
    else
      @spaces = session[:spaces]
    end
    erb:'spaces/index'
  end

  post '/spaces' do

    case params[:submit]
      when 'order_by_price'
        session[:spaces] = Space.order_by('price')
      when 'available_from'
        session[:spaces] = Space.order_by('available_from')
      when 'available_to'
        session[:spaces] = Space.order_by('available_to')
      when 'refresh'
        session[:spaces] = Space.all
     end
    redirect('/spaces')
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
end
