config_file = Rails.root.join('config', 'redis.yml')

if File.exist?(config_file)
  config = YAML.load_file(config_file)[Rails.env]
  $redis = Redis::Store.new config
end
