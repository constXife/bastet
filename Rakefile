require 'bundler'
Bundler.require
require 'sinatra/asset_pipeline'
require 'sinatra/asset_pipeline/task.rb'
require File.expand_path('app/entities/user', File.dirname(__FILE__))
require File.expand_path('app/apies/user', File.dirname(__FILE__))
require File.expand_path('app/apies/token', File.dirname(__FILE__))
require File.expand_path('app/models/user', File.dirname(__FILE__))
require File.expand_path('app/front', File.dirname(__FILE__))
require File.expand_path('app/api', File.dirname(__FILE__))

Sinatra::AssetPipeline::Task.define! Elf::Front::App

desc "API Routes"
task :routes do
  Elf::API::Token.routes.each do |api|
    method  = api.route_method.ljust(10)
    path    = api.route_path
    puts "     #{method} #{path}"
  end
end