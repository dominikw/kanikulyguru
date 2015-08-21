require 'sinatra'

get '/' do
  haml :index, locals: { name: 'kanikuly' }
end

get '/form' do
  haml :form
end

post '/form' do
  haml :form
end
