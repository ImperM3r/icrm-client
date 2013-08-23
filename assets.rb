class Assets < Sinatra::Base
  configure do
    set :assets, (Sprockets::Environment.new { |env|
      env.append_path File.join(root, 'vendor')
      env.append_path File.join(root, 'assets', 'stylesheets')
      env.append_path File.join(root, 'assets', 'javascripts')
      env.append_path File.join(root, 'assets', 'templates')
      env.cache = Sass::CacheStores::Memory.new

      Sprockets::Helpers.configure do |config|
        config.environment = env
        config.public_path = public_folder

        config.debug       = true if development?
      end

      # compress everything in production
      if ENV["RACK_ENV"] == "production" || ENV["RACK_ENV"] == "stage"
        env.js_compressor  = YUI::JavaScriptCompressor.new
        env.css_compressor = YUI::CssCompressor.new
        uid = Digest::MD5.hexdigest(File.dirname(__FILE__))[0,8]
        env.cache = Sprockets::Cache::FileStore.new("./tmp/sinatra-#{uid}")
      end
    })
  end

  get "/assets/*" do |file|
    begin
      if a = settings.assets[file]
        content_type a.content_type

        return a
      else
        return [404, {"Content-Type" => "text/html"}, ["Not Found"]]
      end

    rescue StandardError => err
      logger.error err
      [404, {"Content-Type" => "text/html"}, [err.to_s]]
    end
  end
end
