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
end
