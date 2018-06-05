require 'dotenv-rails'

ForestLiana.env_secret = ENV['FOREST_ADMIN_KEY']
ForestLiana.auth_secret = ENV['FOREST_ADMIN_KEY']

# ForestLiana.env_secret = Rails.application.secrets.forest_env_secret
# ForestLiana.auth_secret = Rails.application.secrets.forest_auth_secret
# 88e36c9c149b80c23bf13becaaf18cc40a1456330a6963852ff38966e100ed3e