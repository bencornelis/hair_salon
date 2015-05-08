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

end
