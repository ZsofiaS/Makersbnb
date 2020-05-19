require 'sinatra'
require './lib/space'
require './lib/booking'
require 'money'
require './currency_config.rb'

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

  get '/spaces/1' do
    Booking.create
    erb :'booking'
  end

  post '/spaces/1' do
    @day = params[:day]
    @month = params[:month]
    @year = params[:year]
    @date = @day + " - " + @month + " - " + @year

    @booking = Booking.instance
    @booking.submit_request("Mars", @date)

    redirect '/requests'
  end

  get '/requests' do
    @booking = Booking.instance
    erb :'requests'
  end
end
