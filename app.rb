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
    @date = params[:day] + " - " + params[:month] + " - " + params[:year]

    p @booking = Booking.create(space_id: @space_id, user_id: @user_id, date: @date)

    redirect '/requests'
  end

  get '/requests' do
    @booking = Booking.instance
    erb :'requests'
  end
end
