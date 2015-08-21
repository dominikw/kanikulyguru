require 'sinatra'
require_relative './app/models/app_data'

get '/' do
  haml :index
end

get '/form' do
  haml :form
end

post '/form' do
  haml :form
end

get '/dashboard' do
  apps = AppData.from_yaml('config/applications.yml')
  haml :dashboard, locals: { apps: apps }
end
