require 'sinatra/base'
require 'sinatra/assetpack'

class KanikulyGuru < Sinatra::Base
  set :root, File.dirname(__FILE__)

  register Sinatra::AssetPack

  assets {
    serve '/css',    from: 'app/css'
    serve '/images', from: 'app/images'

    css :application, '/css/application.css', [
      '/css/app.css'
    ]

    css_compression :sass
  }

  get '/' do
    haml :index
  end

  get '/form' do
    haml :form
  end

  post '/form' do
    haml :form
  end
end
