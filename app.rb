require 'sinatra'
require 'money'
require './lib/space'
require './lib/booking'
require './lib/user'
require './lib/sending_mail'
require './lib/number_converter'
require './lib/validate_signup'
require './currency_config.rb'
require './database_connection_setup'
require 'sinatra/flash'
require 'pony'

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
    if !validate_signup(params)
      persist_form
      redirect '/users/new'
    end
    p params
    if User.create(params[:username], params[:name], params[:email], params[:password])
      send_mail(params[:email])
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
    @user_booking = Booking.find_by_user(id: params[:id])
    @space_names = []
    @user_booking.each do |booking| 
      @space_names << Space.find(booking.space_id).name
    end
    #@user_bookings = Booking.find_by_user(user_id:)
    #@hosted_spaces = Space.find_by_user(user_id)
    erb :'bookings/requests'
  end

  get '/requests/spaces/:id' do
    #@requested_bookings = Bookings.find_by_space(space_id)
    erb :'bookings/spaces'
  end
end
