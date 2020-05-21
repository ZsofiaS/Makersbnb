require 'sinatra'
require 'money'
require './lib/space'
require './lib/booking'
require './lib/user'
require './lib/number_converter'
require './currency_config.rb'
require './database_connection_setup'
require 'sinatra/flash'
require 'pony'

class SpacedOut < Sinatra::Base
  use Rack::Session::Pool
  register Sinatra::Flash

  get '/' do
    !session[:user] ? (redirect '/users/log-in') : (redirect '/spaces')
  end

  get '/users/new' do
    session[:user] = nil
    erb :'users/new'
  end

  post '/users/new' do
    if User.create(params[:username], params[:name], params[:email], params[:password])
      Pony.options = {
        :body => "Thank you for signing up",
        :via => :smtp,
        :via_options => {
          :address              => 'smtp.gmail.com',
          :port                 => '587',
          :enable_starttls_auto => true,
          :user_name            => 'spacedout380@gmail.com',
          :password             => 'kpam rcuj gozz xflp',
          :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
          :domain               => "localhost.localdomain"
        }
      }
      p params[:email]
      Pony.mail :to => params[:email],
                :from => 'spacedout380@gmail.com',
                :subject => 'Thank you for signing up'
      redirect '/users/log-in'
    else
      flash[:notice] = "Email or username already taken"
      redirect '/users/new'
    end
  end

  get '/users/log-in' do
    session[:user] ? (redirect '/spaces') : (erb :'users/login')
  end

  post '/users/log-in' do
    session[:user] = User.authenticate(params[:username], params[:password])
    if session[:user] == nil
      flash[:notice] = "Username or password is incorrect"
      redirect('/users/log-in')
    else
      redirect('/spaces')
    end
  end

  get '/signout' do
    session[:user] = nil
    redirect '/users/log-in'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces/new' do
    Space.new(
      params[:name],
      params[:description],
      Money.new(NumberConverter.two_decimal_place_float_to_int(params[:price_per_night].to_f)),
      Date.parse(params[:available_from]),
      Date.parse(params[:available_to])
    ).save

    redirect('/spaces')
  end

  get '/spaces' do
    @spaces = Space.all
    erb:'spaces/index'
  end

  get '/spaces/:id' do
    @date_invalid = session[:notice]
    erb :'bookings/booking'
  end

  post '/spaces/:id' do
    @user = session[:user]
    @space = Space.find(params[:id])

    if (params[:booking_date] == "")
      session[:notice] = "Please enter a valid date"
      redirect '/spaces/1'
    end

    @booking_date = Date.parse(params[:booking_date])
    @booking = Booking.create(space_id: @space.id, user_id: @user.id, date: @booking_date)
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
