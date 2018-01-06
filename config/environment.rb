# ENV['SINATRA_ENV'] ||= "development"
#
# require 'bundler/setup'
# Bundler.require(:default, ENV['SINATRA_ENV'])
#
# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )
#
# require_all 'app'



source 'http://rubygems.org'
ruby '2.3.1'

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
# gem 'sqlite3', :group => :development
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'shotgun', :group => :development
gem 'pry'
gem 'bcrypt'
gem "tux"
gem 'rack-flash3'

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

require 'bundler/setup'
require 'rack-flash'

Bundler.require

configure :development do
  ENV['SINATRA_ENV'] ||= "development"

  ActiveRecord::Base.establish_connection(
     :adapter => "sqlite3",
     :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
   )
end

configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

  ActiveRecord::Base.establish_connection(
     :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
     :host     => db.host,
     :username => db.user,
     :password => db.password,
     :database => db.path[1..-1],
     :encoding => 'utf8'
  )
end

require_all 'app'
