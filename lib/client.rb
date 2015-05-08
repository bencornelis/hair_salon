class Client
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def ==(other_client)
    (@name == other_client.name) && (@id == other_client.id)
  end
end
