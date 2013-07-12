require './config/environment' #File.expand_path('../config/boot', __FILE__)
require './app'
require './assets'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', :headers => :any, :methods => [:get, :post, :options]
  end
end

#use Rack::ResponseHeaders do |headers|
  #headers['X-Frame-Options'] = 'bar'
#end

use Assets
run Application
