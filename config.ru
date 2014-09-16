require 'reel'
require 'celluloid/autostart'
require 'celluloid/io'

require './app.rb'

Dir.glob('app/**/*.rb').each { |f| require File.join(File.dirname(__FILE__), f) }

Elf::Application.supervise_as :reel

sleep
