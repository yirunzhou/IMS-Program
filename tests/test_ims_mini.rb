require 'minitest/autorun'
require "./lib/ims.rb"
require "./lib/ims/DJTable.rb"
require "./lib/ims/ArtistRecord.rb"


describe "my test" do
    before do
      @table = DJTable.new()

      @table.add_artist("micheal jackson")

      @table.add_track("abc", "mj0")
      @table.add_track("jam", "mj0")
      @table.add_track("beat it", "mj0")
      @table.add_track("thriller", "mj0")

      @table.play(0)
      @table.play(1)
      @table.play(2)
      @table.play(3)
    end

    it "summary" do
        puts @table.get_summary
    end

    it "artist info" do
        puts @table.get_artist_info("mj0")
    end



  end