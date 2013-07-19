class Application < Sinatra::Base
  helpers do
    include Sprockets::Helpers
  end

  get '/' do
    haml :index
  end

  post '/v1/logger' do
    [200, {"Content-type" => "application/json"}, '{ "visitor_id": "123" }']
  end
end
