require 'sinatra'
<<<<<<< HEAD
require './space'
=======
require './lib/booking'
>>>>>>> master

class SpacedOut < Sinatra::Base
  use Rack::Session::Pool

  get '/' do
    'hello spaced out team'
  end

<<<<<<< HEAD
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

end
=======
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
>>>>>>> master
