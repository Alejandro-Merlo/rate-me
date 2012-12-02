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

  before do
    #Autenthication here
  end

  get '/auth/:provider/callback' do
    session[:uid] = request.env['omniauth.auth']["uid"]
    session[:user_name] = request.env['omniauth.auth']["info"]["name"]
    redirect '/'
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
    
    @list    = user.events
    @user    = user
    erb :event_list
  end

  post '/user/:id/events' do |id|
    user     = User.find(id)
    prefix   = "%#{params[:search_field]}%"
    results  = Event.where(:username => user.name).where("name LIKE ?", prefix)

    @results = results
    @list    = user.events
    @user    = user
    erb :event_list_result
  end

  get '/event/:id/rate' do |id|
    event  = Event.find(id)
    @event = event.name

    erb :rate_event
  end

  post '/event/:id/rate' do |id|
    score               = Score.new
    score.qualification = params[:options]
    score.comment       = params[:comment]
    score.event_id      = id
    score.save!

    @message = "score was sent"
    erb :rate_event_result
  end

  get '/event/:id/statistics' do |id|
    event       = Event.find(id)
    @user       = User.find_by_name(event.username)
    
    scores      = Score.where(:event_id => id).scoped
    @positives  = scores.where(:qualification => 'Positive').count
    @neutrals   = scores.where(:qualification => 'Neutral').count
    @negatives  = scores.where(:qualification => 'Negative').count
    @scores     = scores.where("comment NOT LIKE ''") 

    @event      = event
    erb :event_statistics
  end

  get '/user/:id/global_stats' do |id|
    user      = User.find(id)
    @user     = user
    
    events     = Event.joins(:scores).where(:user_id => id).scoped
    @positives = events.where(:scores => {:qualification => 'Positive'}).count
    @neutrals  = events.where(:scores => {:qualification => 'Neutral'}).count
    @negatives = events.where(:scores => {:qualification => 'Negative'}).count
    
    erb :user_statistics
  end

  get '/event/:id/edit' do |id|
    event  = Event.find(id)
    @user  = User.find_by_name(event.username)

    
    @event = event
    erb :event_edit
  end

  post '/event/:id/edit' do |id|
    event  = Event.find(id)
    @user  = User.find_by_name(event.username)
    
    begin
       Event.update(id, :name => params[:name], :date => Date.parse(params[:date]))
    rescue
       @event   = event
       @message = "invalid date"
       return erb :event_edit_fail
    end
    
    erb :event_edit_result
  end

  post '/event/:id/delete?' do |id|
    event = Event.find(id)
    @user = User.find_by_name(event.username)

    @event_id = id
    erb :event_delete
  end

  post '/event/:id/deleted' do |id|
    event  = Event.find(id)
    @user  = User.find_by_name(event.username)
    
    Score.delete_all(:event_id => id)
    event.delete

    erb :event_delete_result
  end

  get '/recover' do
    
    erb :recover_pass, :layout => false
  end

  post '/recover' do
    user = User.find_by_email(params[:email])
    return erb :recover_pass_fail if user == nil

    #Send email

    erb :recover_pass_result
  end
end
