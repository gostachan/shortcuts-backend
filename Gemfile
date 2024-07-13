source "https://rubygems.org"

ruby "3.2.2"
gem "rails", "~> 7.1.3", ">= 7.1.3.3"
gem "sqlite3", "~> 1.4"
gem "mysql2"
gem "puma"
gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "rack-cors"
gem "unicorn"
gem 'rack'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :test do
  gem 'minitest'
  gem 'minitest-reporters'
end

group :development do
end

group :production do
end
