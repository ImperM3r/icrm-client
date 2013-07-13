class Assets < Sinatra::Base
  configure do
    set :assets, (Sprockets::Environment.new { |env|
      env.append_path File.join(root, 'vendor')
      env.append_path File.join(root, 'assets', 'stylesheets')
      env.append_path File.join(root, 'assets', 'javascripts')

      Sprockets::Helpers.configure do |config|
        config.environment = env
        config.public_path = public_folder

        config.debug       = true if development?
      end

      # compress everything in production
      if ENV["RACK_ENV"] == "production" || ENV["RACK_ENV"] == "stage"
        env.js_compressor  = YUI::JavaScriptCompressor.new
        env.css_compressor = YUI::CssCompressor.new
      end
    })
  end

  get "/assets/*" do |file|
    begin
      a = settings.assets[file]
      content_type a.content_type

      a
    rescue
      [404]
    end
  end
end
