require './config/environment' #File.expand_path('../config/boot', __FILE__)
require './app'
require './assets'
#require 'sass/plugin/rack'

puts "My url is #{Settings.url}"

if development?
  Sprockets::Sass.options[:line_comments] = true
end

use Rack::Cors do
  allow do
    origins '*'
    resource '*', :headers => :any, :methods => [:get, :post, :options]
  end
end

use Assets
run Application
