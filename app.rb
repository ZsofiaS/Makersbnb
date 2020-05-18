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
    session[:space] = @newspace
    redirect('/spaces')
  end

  get '/spaces' do
    @newspace = session[:space] 
    erb:'spaces/index'
  end

end