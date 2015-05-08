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
end
