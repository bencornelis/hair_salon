require "spec_helper"

describe(Stylist) do
  describe("#name") do
    it("returns the name of a stylist") do
      stylist = Stylist.new({:name => "John"})
      expect(stylist.name).to eq("John")
    end
  end

  describe("#==") do
    it("is true when two clients have the same name and id") do
      stylist1 = Stylist.new({:name => "John"})
      stylist2 = Stylist.new({:name => "John"})
      expect(stylist1).to eq(stylist2)
    end
  end

  describe(".all") do
    it("is empty initially") do
      expect(Stylist.all).to eq([])
    end
  end

  describe("#save") do
    it("adds a stylist to the database") do
      test_stylist = Stylist.new({:name => "John"})
      test_stylist.save
      expect(Stylist.all).to eq([test_stylist])
    end
  end

  describe("#delete") do
    it("removes the stylist from the database") do
      test_stylist = Stylist.new({:name => "Sally"})
      test_stylist.save
      test_stylist.delete
      expect(Stylist.all).to eq([])
    end

    it("sets the stylist's client's stylist_ids to nil") do
      test_stylist = Stylist.new({:name => "Sally"})
      test_stylist.save
      sally_client = Client.new({:name => "Cindy", :stylist_id => test_stylist.id})
      sally_client.save
      test_stylist.delete
      expect(Client.find(sally_client.id).stylist_id).to eq(nil)
    end
  end

  describe(".find") do
    it("finds a stylist by their id") do
      test_stylist = Stylist.new({:name => "Joe"})
      test_stylist.save
      expect(Stylist.find(test_stylist.id)).to eq(test_stylist)
    end
  end

  describe("#update") do
    it("can change the name of the stylist") do
      test_stylist = Stylist.new({:name => "Joe"})
      test_stylist.save
      test_stylist.update({:name => "Joey"})
      expect(test_stylist.name).to eq("Joey")
    end
  end

  describe("#clients") do
    it("is empty at first") do
      test_stylist = Stylist.new({:name => "Joe"})
      test_stylist.save
      expect(test_stylist.clients).to eq([])
    end
  end

  describe("#add_client") do
    it("adds a client to a stylist") do
      test_stylist = Stylist.new({:name => "Joe"})
      test_stylist.save
      test_client = Client.new({:name => "Sally"})
      test_client.save
      test_stylist.add_client(test_client.id)
      expect(test_stylist.clients.first.id).to eq(test_client.id)
    end
  end

  describe("#status") do
    it("results a string with boostrap text style text-success if a stylist has no clients") do
      test_stylist = Stylist.new({:name => "Joe"})
      test_stylist.save
      expect(test_stylist.status).to eq("<span class='text-success'>No clients</span>")
    end

    it("results a string with boostrap text style text-danger if a stylist has 5 clients") do
      test_stylist = Stylist.new({:name => "Joe"})
      test_stylist.save
      ['Sally','Tim','Jim','Ben','Cindy'].each do |client_name|
        test_client = Client.new({:name => client_name})
        test_client.save
        test_stylist.add_client(test_client.id)
      end
      expect(test_stylist.status).to eq("<span class='text-danger'>Full</span>")
    end

    it("results a string with boostrap text style text-warning if a stylist has 1-4 clients") do
      test_stylist = Stylist.new({:name => "Joe"})
      test_stylist.save
      ['Sally','Tim','Jim'].each do |client_name|
        test_client = Client.new({:name => client_name})
        test_client.save
        test_stylist.add_client(test_client.id)
      end
      expect(test_stylist.status).to eq("<span class='text-warning'>Busy</span>")
    end

  end
end
