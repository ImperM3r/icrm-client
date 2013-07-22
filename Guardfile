# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload', :grace_period => 0.8 do
  watch(%r{views/.+\.(erb|haml|slim)$})
  watch(%r{helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(assets/\w+/(.+\.(css|sass|scss|js|coffee|html))).*}) { |m| "/assets/#{m[3]}" }
end

