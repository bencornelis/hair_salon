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
    DB.exec("UPDATE clients SET stylist_id = NULL WHERE stylist_id = #{@id};")
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

  def client_count
    result = DB.exec("SELECT count(*) FROM clients WHERE stylist_id = #{@id};")
    client_count = result.first.fetch("count").to_i
  end

  def self.taking_clients
    Stylist.all.select { |stylist| stylist.client_count < 5 }
  end

  def self.with_clients
    Stylist.all.select { |stylist| stylist.client_count > 0 }
  end

  def self.percent_with_clients
    if Stylist.all.any?
      100*(Stylist.with_clients.length)/(Stylist.all.length)
    else
      0
    end
  end

  def status
    case client_count
    when 0
      "<span class='text-success'>No clients</span>"
    when 5
      "<span class='text-danger'>Full</span>"
    else
      "<span class='text-warning'>Busy</span>"
    end
  end
end
