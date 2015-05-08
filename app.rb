require "sinatra"
require "sinatra/reloader"
require "./lib/client"
require "./lib/stylist"
also_reload('lib/**/*.rb')
require "pg"

DB = PG.connect({:dbname => "hair_salon"})

get('/') do
  erb(:index)
end
