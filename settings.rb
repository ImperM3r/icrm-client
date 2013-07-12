require 'settingslogic'

class Settings < Settingslogic
  source File.expand_path('../settings.yml', __FILE__)
  load!
end
