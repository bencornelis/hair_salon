class Client
  attr_reader :name, :id, :stylist_id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @stylist_id = attributes[:stylist_id]
  end

  def ==(other_client)
    (@name == other_client.name) && (@id == other_client.id) && (@stylist_id == other_client.stylist_id)
  end

  def save
    result = DB.exec("INSERT INTO clients (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def delete
    DB.exec("DELETE FROM clients WHERE id = #{@id};")
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@id};")

    @stylist_id = attributes.fetch(:stylist_id, @stylist_id)
    unless @stylist_id == nil
      DB.exec("UPDATE clients SET stylist_id = #{@stylist_id} WHERE id = #{@id};")
    else
      DB.exec("UPDATE clients SET stylist_id = NULL WHERE id = #{@id};")
    end
  end

  def self.all
    results = DB.exec("SELECT * FROM clients;")
    clients = []
    results.each do |result|
      name = result.fetch("name")
      id = result.fetch("id").to_i
      stylist_id = result.fetch("stylist_id").to_i
      stylist_id = nil if stylist_id == 0
      clients << Client.new({:name => name, :id => id, :stylist_id => stylist_id})
    end
    clients
  end

  def self.unassigned
    Client.all.select { |client| client.stylist_id == nil }
  end

  def self.find(client_id)
    result = DB.exec("SELECT * FROM clients WHERE id = #{client_id};")
    name = result.first.fetch("name")
    id = result.first.fetch("id").to_i
    stylist_id = result.first.fetch("stylist_id").to_i
    stylist_id = nil if stylist_id == 0
    Client.new({:name => name, :id => id, :stylist_id => stylist_id})
  end

  def status
    if @stylist_id == nil
      "<span class='text-success'>Unassigned</span>"
    else
      "<span class='text-warning'>Assigned</span>"
    end
  end
end
