require 'sinatra'
require 'sprockets'
require 'sprockets-helpers'
require 'coffee_script'

class Application < Sinatra::Base
  set :assets, Sprockets::Environment.new(root)

  configure do
    assets.append_path File.join(root, 'widget', 'stylesheets')
    assets.append_path File.join(root, 'widget', 'javascripts')
    assets.append_path File.join(root, 'widget', 'components')

    Sprockets::Helpers.configure do |config|
      config.environment = assets
      config.prefix      = '/widget'
    end
  end

  helpers do
    include Sprockets::Helpers
  end

  get '/' do
    erb :index
  end
end
