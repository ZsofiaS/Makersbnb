require 'sinatra'
require './space'

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

end