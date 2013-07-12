class Settings < Settingslogic
  source File.expand_path('../settings.yml', __FILE__)
  namespace ENV['RACK_ENV']
  load!
end
