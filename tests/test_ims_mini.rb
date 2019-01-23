require 'minitest/autorun'
require "./lib/ims.rb"
require "./lib/ims/DJTable.rb"
require "./lib/ims/ArtistRecord.rb"
require "./lib/ims/Main.rb"

require 'yaml/store'


describe "my test" do
    before do
      @store = YAML::Store.new('./data/test_store.yml')
      @table = @store.transaction{@store[:table]}
      
      @store.transaction do  
        @store[:last_run] = Time.now
      end

      @main = Main.new

      @mj0_info = "Artist Name:\n\tmicheal jackson\nTrack Name, Track ID:\n\tabc, 0\n\tjam, 1\n\tbeat it, 2\n\tthriller, 3\n"
      @info = "Recently played tracks:\n\tbeat it\n\tthriller\n\tbeat it\nArtist Name, Artist ID:\n\tmicheal jackson, mj0\n\tanderson paak, ap1\n\tan artist's name, aan2\n"

      @abc_info = "Track Name: abc, Artist Name: micheal jackson"

      @add_track_billie_jean = "Successfully added, track id '6'"

      @add_artist_fujisawa_mamoru = "Successfully added, artist id 'fm3'"

      @help_msg = <<~EOF
      IMS Command Mannual:

      help
        get help messages of all commands in this IMS app
      
      exit
        save and exit IMS
      
      info
        display recently played tracks' info
      
      info artist <artist_id>
        display this artist's info
      
      info track <track_id>
        display this track's info
      
      add artist <artist_name>
        add this artist to the table, display the id assigned to this new artist
      
      add track <track_name> by <artist_id>
        add this track to this artist's record, display the id assigned to this new track
      
      count tracks by <artist_id>
        display # of tracks of this artist
      
      list tracks by <aritist_id>
        display info of all the tracks of this artist

      EOF

    end

    # TODO: error test

    it "summary" do
      @table.info.must_equal @info
    end

    it "artist info" do
      @table.info_artist("mj0").must_equal @mj0_info
    end

    it "count tracks" do
      @table.count_tracks_by("mj0").must_equal "4"
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

    it "count track" do
      @main.execute("count tracks by mj0").must_equal "4"
    end

    it "add track" do
      @main.execute("add track billie jean by mj0").must_equal @add_track_billie_jean
    end

    it "add artist" do
      @main.execute("add artist fujisawa mamoru").must_equal @add_artist_fujisawa_mamoru
    end

    it "help" do
      @table.help.must_equal @help_msg
    end

    it "run" do
      @main.run
    end

  end