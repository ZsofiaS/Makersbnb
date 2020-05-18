require 'sinatra'

class SpacedOut < Sinatra::Base
  use Rack::Session::Pool

  get '/' do
    'hello spaced out team'
  end

  get '/spaces/1' do
    'Request booking'
  end
end
