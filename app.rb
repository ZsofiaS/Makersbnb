require 'sinatra'
require './space'
require './lib/booking'
require './database_connection_setup'

class SpacedOut < Sinatra::Base
  use Rack::Session::Pool

  get '/' do
    'hello spaced out team'
  end

  get '/spaces/new' do
    erb:'spaces/new'
  end

  post '/spaces/new' do
    @newspace = Space.new(params[:name])
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
