require './config/environment' #File.expand_path('../config/boot', __FILE__)
require './app'
require './assets'
require 'rack/cache'
require 'dalli'

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

use Rack::Cache,
  :verbose     => true,
  :default_ttl => 60,
  #:metastore   => 'heap:/',
  #:entitystore => 'heap:/'
  :metastore   => 'file:./tmp/cache/rack/meta',
  :entitystore => 'file:./tmp/cache/rack/body'
  #:metastore   => "memcached://localhost:11211/convead_client/meta",
  #:entitystore => "memcached://localhost:11211/convead_client/body"

use Assets
run Application
