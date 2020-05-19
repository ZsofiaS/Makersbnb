require 'sinatra'
require './lib/space'
require './lib/booking'
require 'money'
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

  get '/users/log-in' do
    erb :'users/login'
  end

  post '/users/log-in' do
    erb :'users/login'
  end

  post '/users/redirectlogin' do
    'Welcome, test'
    redirect('/spaces')
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces/new' do
    @newspace = Space.new(Money,
    params[:name],
    params[:description],
    NumberConverter.two_decimal_place_float_to_int(params[:price_per_night].to_f))
    Space.all.push(@newspace)
    redirect('/spaces')
  end

  get '/spaces' do
    @spaces = Space.all
    erb:'spaces/index'
  end

  get '/spaces/:id' do
    # @space = Space.find(id: params[:id])
    erb :'bookings/booking'
  end

  post '/spaces/:id' do
    # Place holders ----
    @user_id = 1
    # -----------------
    @date = Time.new(params[:year], params[:month], params[:day])
    @booking = Booking.create(space_id: params[:id], user_id: @user_id, date: @date)
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
