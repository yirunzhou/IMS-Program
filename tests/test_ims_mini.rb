require 'minitest/autorun'
require "./lib/ims.rb"
require "./lib/ims/DJTable.rb"
require "./lib/ims/ArtistRecord.rb"

require 'yaml/store'


describe "my test" do
    before do
      store = YAML::Store.new('./data/test_store.yml')
      @table = store.transaction{store[:table]}

      store.transaction do  
        store[:last_run] = Time.now
      end

    end

    it "summary" do
        puts @table.get_summary
    end

    it "artist info" do
        puts @table.get_artist_info("mj0")
    end



  end