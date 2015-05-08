require "sinatra"
require "sinatra/reloader"
require "./lib/client"
require "./lib/stylist"
also_reload('lib/**/*.rb')
require "pg"
require "pry"

DB = PG.connect({:dbname => "hair_salon"})

get("/") do
  @stylists = Stylist.all
  @clients = Client.all
  erb(:index)
end

post("/stylists/new") do
  name = params.fetch("stylist_name")
  new_stylist = Stylist.new({:name => name})
  new_stylist.save
  redirect("/")
end

post("/clients/new") do
  name = params.fetch("client_name")
  new_client = Client.new({:name => name})
  new_client.save
  redirect("/")
end

get("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i)
  erb(:stylist)
end

delete("/stylists/:id") do
  stylist = Stylist.find(params.fetch("id").to_i)
  stylist.delete
  redirect("/")
end

patch("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i)
  new_name = params.fetch("stylist_name")
  @stylist.update({:name => new_name})
  erb(:stylist)
end

post("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i)
  client_id = params.fetch("clients").to_i
  @stylist.add_client(client_id)
  erb(:stylist)
end

get("/clients/:id") do
  @client = Client.find(params.fetch("id").to_i)
  erb(:client)
end

delete("/clients/:id") do
  client = Client.find(params.fetch("id").to_i)
  client.delete
  redirect("/")
end

patch("/clients/:id") do
  @client = Client.find(params.fetch("id").to_i)
  new_name = params.fetch("client_name")
  @client.update({:name => new_name})
  erb(:client)
end
