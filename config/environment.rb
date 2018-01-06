ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )

configure :development do
  ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)
end

configure :production do
  db = URI.parse(ENV['HEROKU_POSTGRESQL_COBALT_URL'] || 'postgres://xejhvedmikhhzx:401fd65eb77d408dd4ba12a89a1936df2ca7138d07bf6a62c159a8173f8c420c@ec2-107-22-183-40.compute-1.amazonaws.com:5432/ddq7f3ul9uboem')

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

require 'rack-flash'

require_all 'app'
