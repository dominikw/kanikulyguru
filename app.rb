require 'sinatra'
require 'sinatra/base'
require 'sinatra/assetpack'
require_relative './app/models/app_data'

class KanikulyGuru < Sinatra::Base
  set :root, File.dirname(__FILE__)

  register Sinatra::AssetPack

  assets {
    serve '/css',    from: 'app/css'
    serve '/images', from: 'app/images'
    serve '/js', from: 'app/js'

    css :application, '/css/application.css', [
      '/css/app.css'
    ]
    js :application, '/css/application.js', [
      '/js/app.js'
    ]

    css_compression :sass
  }

  get '/' do
    haml :index
  end

  post '/' do
    haml :index
  end

  get '/dashboard' do
    apps = AppData.from_yaml('config/applications.yml')
    haml :dashboard, locals: { apps: apps }
  end
end

