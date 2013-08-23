class Application < Sinatra::Base
  require 'semver'
  helpers do
    include Sprockets::Helpers
  end

  get '/' do
    @title = 'Convead Widget Index'
    haml :index, layout: :layout
  end

  get '/about' do
    @title = 'Convead Widget About'
    haml :about, layout: :layout
  end

  post '/v1/ping' do
    content_type :json
  end

  post '/v1/logger' do
    content_type :json
    { visitor: { id: 123 } }.to_json
  end
end
