require 'sinatra'
require 'money'
require './lib/space'
require './lib/booking'
require './lib/user'
require './lib/sending_mail'
require './lib/number_converter'
require './lib/validate_signup'
require './lib/greeting_generator'
require './currency_config.rb'
require './database_connection_setup'
require 'sinatra/flash'
require 'date'
require 'pony'

class SpacedOut < Sinatra::Base
  use Rack::Session::Pool
  register Sinatra::Flash

  before do
    @generated_user_greeting = GreetingGenerator.greet
  end

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
    if params[:available_from] > params[:available_to]
      flash[:notice] = "Invalid dates"
      redirect ('/spaces/new')
    else
     Space.new(
       nil,
       params[:name],
        params[:description],
        Money.new(NumberConverter.two_decimal_place_float_to_int(params[:price_per_night].to_f)),
        Date.parse(params[:available_from]),
        Date.parse(params[:available_to]),
        session[:user].id
     ).save
     session[:spaces] = Space.all
     redirect('/spaces')
    end
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
      when 'Price: low to high'
        session[:spaces] = Space.order_by_asc('price')
      when 'Price: high to low'
        session[:spaces] = Space.order_by_desc('price')
      when 'find dates'
        if ( params[:checkin_date] == "" || params[:checkout_date] == "" )
          session[:spaces] = Space.all
        else
        session[:spaces] = Space.order_by_dates(Date.parse(params[:checkin_date]),Date.parse(params[:checkout_date]))
        end
      else
        session[:spaces] = Space.all
      end

    redirect('/spaces')
  end

  get '/spaces/:id' do
    @date_invalid = session[:notice]
    erb :'bookings/booking'
  end

  post '/spaces/:id' do
    # ADD A BOOKING
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
    erb :'bookings/requests'
  end

  get '/requests/spaces/:id' do
    erb :'bookings/spaces'
  end


  get '/requests' do
    @user_bookings = Booking.find_by_user(id: session[:user].id)
    @booking_spaces = []
    @user_bookings.each do |booking|
      @booking_spaces << Space.find(booking.space_id)
    end

    @user_spaces = Space.find_by_user(session[:user].id)
    @requests_received = []
    @user_spaces.each do |space|
      Booking.find_by_space(id: space.id).each do |request|
        @requests_received << request
      end
    end
    #p @requests_received[0].user_id

    erb :'/requests/index'
  end
end
