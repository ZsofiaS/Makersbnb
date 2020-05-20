require 'sinatra'
require 'money'
require './lib/space'
require './lib/booking'
require './lib/user'
require './lib/number_converter'
require './currency_config.rb'
require './database_connection_setup'

class SpacedOut < Sinatra::Base
  use Rack::Session::Pool

  get '/' do
    'hello spaced out team'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users/new' do
    session[:username] = params[:username]
    session[:password] = params[:password]
    User.create(params[:username], params[:name], params[:email], params[:password])
    redirect '/users/log-in'
  end

  get '/users/log-in' do
    erb :'users/login'
  end

  post '/users/log-in' do
    'Welcome, test'
    session[:user] = User.new(params[:username], params[:password])
    session[:user].get_user_data
    redirect('/spaces')
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces/new' do
    @newspace = Space.new(
      params[:name], 
      params[:description],
      Money.new(NumberConverter.two_decimal_place_float_to_int(params[:price_per_night].to_f)),
      Date.parse(params[:available_from]),
      Date.parse(params[:available_to])
    )
    Space.all.push(@newspace)
    redirect('/spaces')
  end

  get '/spaces' do
    @spaces = Space.all 
    erb:'spaces/index'
  end

  get '/spaces/1' do
    erb :'booking'
  end

  post '/spaces/1' do
    # Place holders ----
    @space_id = 1
    @user_id = 1
    # -----------------
    @date = Time.new(params[:year], params[:month], params[:day])

    p @date

    @booking = Booking.create(space_id: @space_id, user_id: @user_id, date: @date)
    session[:booking_id] = @booking.id

    p @booking
    redirect '/requests'
  end

  get '/requests' do
    @booking = Booking.find(id: session[:booking_id])
    erb :'requests'
  end
end
