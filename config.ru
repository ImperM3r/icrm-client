require './config/environment' #File.expand_path('../config/boot', __FILE__)
require './app'
require './assets'

use Assets
run Application
