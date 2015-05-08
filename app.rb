require "sinatra"
require "sinatra/reloader"
require "./lib/client"
require "./lib/stylist"
also_reload('lib/**/*.rb')
require "pg"

DB = PG.connect({:dbname => "hair_salon"})

get("/") do
  @stylists = Stylist.all
  @clients = Client.all
  erb(:index)
end

get("/stylists/new") do
  erb(:stylist_add)
end

post("/stylists/new") do
  name = params.fetch("name")
  new_stylist = Stylist.new({:name => name})
  new_stylist.save
  redirect("/")
end

get("/clients/new") do
  erb(:client_add)
end

post("/clients/new") do
  name = params.fetch("name")
  new_client = Client.new({:name => name})
  new_client.save
  redirect("/")
end
