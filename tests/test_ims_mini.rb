require 'minitest/autorun'
require "./lib/ims.rb"
require "./lib/ims/DJTable.rb"
require "./lib/ims/ArtistRecord.rb"
require "./lib/ims/Main.rb"

require 'yaml/store'


describe "my test" do
    before do
      # testing mode set to true
      @main = Main.new(true)
      
      # expected msg
      @mj0_info = "Artist Name:\n\tmichael jackson\nTrack Name, Track ID:\n\tabc, 0\n\tjam, 1\n\tbeat it, 2\n\tthriller, 3\n"
      @info = "Recently played tracks:\n\tthriller\n\tbeat it\n\tjam\nArtist Name, Artist ID:\n\tmichael jackson, mj0\n\tanderson paak, ap1\n\tan artist's name, aan2\n"
      @abc_info = "Track Name: abc, Artist Name: michael jackson"
      @add_track_billie_jean = "Successfully added, track id '6'"
      @add_artist_fujisawa_mamoru = "Successfully added, artist id 'fm3'"
      @invalid_command = "-IMS: command not found"
      store = YAML::Store.new('./data/help_msg.yml')
      @help_msg = store.transaction{store[:help_msg]}
    end

    it "info" do
      @main.execute("info").must_equal @info
    end

    it "artist info" do
      @main.execute("info artist mj0").must_equal @mj0_info
    end

    it "info track" do
      @main.execute("info track 0").must_equal @abc_info
    end

    it "count tracks by" do
      @main.execute("count tracks by mj0").must_equal "4"
    end

    it "add track" do
      @main.execute("add track billie jean by mj0").must_equal @add_track_billie_jean
    end

    it "add artist" do
      @main.execute("add artist fujisawa mamoru").must_equal @add_artist_fujisawa_mamoru
    end

    it "help" do
      @main.execute("help").must_equal @help_msg
    end

    it "wrong command" do
      @main.execute("wrong command").must_equal @invalid_command
    end
  end