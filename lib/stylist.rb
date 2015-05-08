class Stylist
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def ==(other_stylist)
    (@name == other_stylist.name) && (@id == other_stylist.id)
  end

  def save
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM stylists;")
    stylists = []
    results.each do |result|
      name = result.fetch("name")
      id = result.fetch("id").to_i
      stylists << Stylist.new({:name => name, :id => id})
    end
    stylists
  end

  def delete
    DB.exec("DELETE FROM stylists WHERE id = #{@id};")
    DB.exec("UPDATE clients SET stylist_id = 0 WHERE stylist_id = #{@id};")
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")
  end

  def add_client(client_id)
    client = Client.find(client_id)
    client.update({:stylist_id => @id})
  end

  def clients
    results = DB.exec("SELECT * FROM clients WHERE stylist_id = #{@id};")
    clients = []
    results.each do |result|
      name = result.fetch("name")
      id = result.fetch("id").to_i
      clients << Client.new({:name => name, :id => id, :stylist_id => @id})
    end
    clients
  end

  def self.find(stylist_id)
    result = DB.exec("SELECT * FROM stylists WHERE id = #{stylist_id};")
    name = result.first.fetch("name")
    id = result.first.fetch("id").to_i
    Stylist.new({:name => name, :id => id})
  end
end
