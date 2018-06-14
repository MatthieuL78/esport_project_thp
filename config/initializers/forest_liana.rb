require 'dotenv-rails'

if Rails.env.development?
  ForestLiana.env_secret = ENV['FOREST_DEV_SECRET']
else
  ForestLiana.env_secret = ENV['FOREST_ENV_SECRET']
end	
ForestLiana.auth_secret = ENV['FOREST_AUTH_SECRET']