require 'sinatra'
require './lib/booking'

class SpacedOut < Sinatra::Base
  use Rack::Session::Pool

  get '/' do
    'hello spaced out team'
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
