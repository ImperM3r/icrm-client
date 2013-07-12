require 'sprockets'
require './app'
require './settings'

map '/widget' do
  run Application.assets
end

run Application
