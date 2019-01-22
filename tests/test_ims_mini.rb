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
      # @table.add_artist("anderson paak")
      


    end

    it "summary" do
        @table.get_summary.must_equal "Recently played tracks:\nthriller\nbeat it\njam\n"
    end

    it "artist info" do
        @table.get_artist_info("mj0").must_equal "Artist Name:\nmicheal jackson\nTrack Name, Track ID:\nabc, 0\njam, 1\nbeat it, 2\nthriller, 3\n"
    end

    it "str pre" do
        @main.preprocess(" INFO   mj0   1")
    end

    it "count tracks" do
        @table.count_tracks("mj0").must_equal 4
    end

    it "exit or help command" do
        @main.execute("help").must_equal("exit || help")
    end

    it "info command" do
        @main.execute("info").must_equal("info")
        @main.execute("info artist mj0")
        .must_equal(["info artist", "mj0"])
        @main.execute("info track 0")
        .must_equal(["info track", "0"])
    end

    it "add command" do
        @main.execute("add artist anderson paak")
        .must_equal(["add artist", "anderson paak"])
        @main.execute("add track the free nationals by ap0")
        .must_equal(["add track", "the free nationals", "ap0"])
    end

    it "count or list command" do
        @main.execute("count tracks by ap0").must_equal(["count tracks by", "ap0"])
        @main.execute("list tracks by ap0").must_equal(["list tracks by", "ap0"])
    end

    it "mix command" do
        @main.execute("add track the free nationals exit by ap0")
        .must_equal(["add track", "the free nationals exit", "ap0"])
    end

    it "not valid" do
        # incomplete
        @main.execute("count tracks").must_equal("not valid command")

        # other char
        @main.execute("exit0").must_equal("not valid command")
        @main.execute("adsdfk").must_equal("not valid command")
    end

    it "valid command with other chars" do
        @main.execute("help sajdks").must_equal("exit || help")
    end
  end