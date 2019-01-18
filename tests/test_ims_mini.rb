require 'minitest/autorun'
require "./lib/ims.rb"
require "./lib/ims/DJTable.rb"
require "./lib/ims/ArtistRecord.rb"


describe "my test" do
    before do
      @table = DJTable.new()

      @table.add_artist("micheal jackson")

      @table.add_track("abc", "mj")
      @table.add_track("jam", "mj")
      @table.add_track("beat it", "mj")
      @table.add_track("thriller", "mj")

      @table.play("jam")
      @table.play("abc")
      @table.play("thriller")
      @table.play("beat it")
    end
  
    it "testing" do
      
    end

    it "summary" do
  
    
  end