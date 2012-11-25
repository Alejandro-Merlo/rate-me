require 'sinatra/base'
require 'sinatra/activerecord'
require 'date'
require './models/event.rb'
require './models/score.rb'
require './models/user.rb' # your models
# require 'json' #json support

class MyApplication < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions


  #:nocov:
  configure :production,:staging do
    set :database, ENV['DATABASE_URL']
  end

  configure :development do
    set :database, 'sqlite:///dev.db'
  end
  #:nocov:

  configure :test do
    set :database, 'sqlite:///dev.db'
  end

  get '/' do
    erb :home
  end

  get '/login' do
    erb :home
  end

  post '/login' do
    user = User.find_by_name_and_password(params[:username], params[:password])
    return erb :login_fail if (user == nil)

    @user_id = user.id.to_s()
    @message = "You have logged in rate me!"
    erb :login_result
  end

  get '/sign' do
    erb :user_new
  end

  post '/sign' do
    
    username = params[:username]
    db_user = User.find_by_name(username)
    if (db_user != nil)
       @message = "username already exists"
       return erb :user_new_repeated
    end

    user = User.new
    user.name     = username
    user.password = params[:password]
    user.email    = params[:email]
    user.save

    @message = "account was created"
    erb :user_new_result
  end

  get '/user/:id/new' do |id|
    
    @user_id = id
    erb :event_new
  end

  post '/user/:id/new' do |id|
    user           = User.find(id)
    @user_id       = id

    event          = Event.new
    event.name     = params[:name]

    begin
       event.date = Date.parse(params[:date])
    rescue
       @message = "invalid date"
       return erb :event_new_fail
    end

    event.username = user.name
    event.user_id  = id
    event.save

    @message = "Event created"
    @event   = event
    erb :event_new_result
  end

  get '/user/:id/events' do |id|
    user = User.find(id)
    
    @list    = Event.find_all_by_username(user.name)
    @user_id = id
    erb :event_list
  end

  get '/event/:id/rate' do |id|
    event = Event.find(id)
    @event = event.name

    erb :rate_event
  end

  post '/event/:id/rate' do |id|
    score = Score.new
    score.qualification = params[:options]
    score.comment       = params[:comment]
    score.event_id      = id
    score.save

    @message = "score was sent"
    erb :rate_event_result
  end
end
