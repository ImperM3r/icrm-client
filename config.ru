require 'sprockets'
require './app'

map '/widget' do
  run Application.assets
end

run Application
