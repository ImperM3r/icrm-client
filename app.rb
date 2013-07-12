class Application < Sinatra::Base
  helpers do
    include Sprockets::Helpers
  end

  get '/' do
    erb :index
  end
end
