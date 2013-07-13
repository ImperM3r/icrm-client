class Settings < Settingslogic
  local = File.expand_path('../application.local.yml', __FILE__)
  source local if File.exists? local

  source File.expand_path('../application.yml', __FILE__)
  
  namespace ENV['RACK_ENV']
  load!
end
