require 'bundler'
Bundler.require
require 'sinatra/asset_pipeline'
require 'haml_coffee_assets'

require File.expand_path('app/version', File.dirname(__FILE__))
require File.expand_path('app/entities/user', File.dirname(__FILE__))
require File.expand_path('app/apis/token', File.dirname(__FILE__))
require File.expand_path('app/models/user', File.dirname(__FILE__))
require File.expand_path('app/front', File.dirname(__FILE__))
require File.expand_path('app/api', File.dirname(__FILE__))

map '/api' do
  run Elf::API::App
end

run Elf::Front::App