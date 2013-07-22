class Application < Sinatra::Base
  require 'semver'
  helpers do
    include Sprockets::Helpers
  end

  get '/' do
    haml :index
  end

  post '/v1/logger' do
    content_type :json
    { visitor: { id: 123 } }.to_json
  end
end
