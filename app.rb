require 'sinatra'

get '/' do
  haml :index
end

get '/form' do
  haml :form
end

post '/form' do
  haml :form
end
