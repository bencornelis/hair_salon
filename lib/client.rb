class Client
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def ==(other_client)
    (@name == other_client.name) && (@id == other_client.id)
  end

  def save
    result = DB.exec("INSERT INTO clients (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def delete
    DB.exec("DELETE FROM clients WHERE id = #{id};")
  end

  def self.all
    results = DB.exec("SELECT * FROM clients;")
    clients = []
    results.each do |result|
      name = result.fetch("name")
      id = result.fetch("id").to_i
      clients << Client.new({:name => name, :id => id})
    end
    clients
  end
end
