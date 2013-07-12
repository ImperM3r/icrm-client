class Assets < Sinatra::Base
  configure do
    set :assets, (Sprockets::Environment.new { |env|
      env.append_path File.join(root, 'widget', 'stylesheets')
      env.append_path File.join(root, 'widget', 'javascripts')
      env.append_path File.join(root, 'widget', 'components')

      Sprockets::Helpers.configure do |config|
        config.environment = env
        config.public_path = public_folder

        config.debug       = true if development?
      end

      # compress everything in production
      if ENV["RACK_ENV"] == "production"
        env.js_compressor  = YUI::JavaScriptCompressor.new
        env.css_compressor = YUI::CssCompressor.new
      end
    })
  end

  get "/assets/:file.:ext" do |file, ext|
    a = settings.assets["#{file}.#{ext}"]
    content_type a.content_type

    a
  end
end
