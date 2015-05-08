require "spec_helper"

describe(Client) do
  describe("#name") do
    it("returns the name of a client") do
      test_client = Client.new({:name => "Joe"})
      expect(test_client.name).to eq("Joe")
    end
  end

  describe("#==") do
    it("is true when two clients have the same name and id") do
      client1 = Client.new({:name => "Joe"})
      client2 = Client.new({:name => "Joe"})
      expect(client1).to eq(client2)
    end
  end

  describe(".all") do
    it("is empty initially") do
      expect(Client.all).to eq([])
    end
  end

  describe("#save") do
    it("adds a client to the database") do
      test_client = Client.new({:name => "Joe"})
      test_client.save
      expect(Client.all).to eq([test_client])
    end
  end

  describe("#delete") do
    it("removes the client from the database") do
      test_client = Client.new({:name => "Joe"})
      test_client.save
      test_client.delete
      expect(Client.all).to eq([])
    end
  end

  describe("#update") do
    it("can change the name of the client") do
      test_client = Client.new({:name => "Joe"})
      test_client.save
      test_client.update({:name => "Joey"})
      expect(test_client.name).to eq("Joey")
    end

    it("can assign or reassign a client to a stylist") do
      test_client = Client.new({:name => "Joe"})
      test_client.save
      test_client.update({:stylist_id => 3})
      expect(test_client.stylist_id).to eq(3)
    end
  end

  describe(".find") do
    it("finds a client by their id") do
      test_client = Client.new({:name => "Joe", :stylist_id => 3})
      test_client.save
      expect(Client.find(test_client.id)).to eq(test_client)
    end
  end
end
