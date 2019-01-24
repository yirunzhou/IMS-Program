require "./lib/ims/DJTable.rb"
require 'yaml/store'

class Main
  def initialize(test=false)
    if !test
      @store = YAML::Store.new('./data/data.yml')  
    else
      @store = YAML::Store.new('./data/test_store.yml')
    end
    @table = @store.transaction{@store[:table]}
    @table = DJTable.new if @table == nil
  end

  def run()
    while true
      print "ims> "
      input = preprocess(gets.chomp)
      begin
        puts execute(input)
      rescue StandardError => e
        puts e.message
      end
    end
  end

  def preprocess(str)
    str = str.downcase
    return str.split.join(" ")
  end

  # input is processed to downcase words splited by 1 space
  def execute(str)
    msg = ""

    if str.match(/^exit\b/)
      save
      exit
    elsif str.match(/^help\b/)
      msg = @table.help

    elsif match = str.match(/^info track ([\s\S]*)/)
      msg = @table.info_track(match.captures[0])

    elsif match = str.match(/^info artist ([\s\S]*)/)
      msg = @table.info_artist(match.captures[0])

    elsif match = str.match(/^info\b/)
      msg = @table.info

    elsif match = str.match(/^count tracks by ([\s\S]*)/)
      msg = @table.count_tracks_by(match.captures[0])

    elsif match = str.match(/^list tracks by ([\s\S]*)/)
      msg = @table.list_tracks_by(match.captures[0])

    elsif match = str.match(/^add track ([\s\S]*) by ([\s\S]*)\b/)
      msg = @table.add_track(match.captures[0], match.captures[1])

    elsif match = str.match(/^add artist ([\s\S]*)/)
      msg = @table.add_artist(match.captures[0])

    elsif match = str.match(/^play ([\s\S]*)\b/)
      msg = @table.play(match.captures[0])
      
    else
      msg = "-IMS: command not found"
    end

    return msg
  end

  def save
    @store.transaction do
      @store[:table] = @table
      @store[:last_run] = Time.now
    end
  end
end