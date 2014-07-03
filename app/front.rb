module Elf
  module Front
    class App < Sinatra::Base
      register Sinatra::AssetPipeline
      set :root, File.expand_path('../', __FILE__)
      set :public_folder, 'public'

      configure :development do
        register Sinatra::Reloader
      end

      configure :production do
        set :assets_precompile, %w(elf.js application.css *.png *.jpg *.svg *.eot *.ttf *.woff)
        set :assets_prefix, ['assets', 'vendor/assets', File.dirname(HamlCoffeeAssets.helpers_path)]
        set :assets_css_compressor, :sass
        set :assets_js_compressor, :uglifier
      end

      get '/*' do
        haml :index
      end
    end
  end
end
