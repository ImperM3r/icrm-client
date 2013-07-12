class Settings < Settingslogic
  source File.expand_path('../application.yml', __FILE__)
  namespace ENV['RACK_ENV']
  load!
end
