

msg = <<~EOF
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

require "./lib/ims/DJTable.rb"
require 'yaml/store'

class Main
    def initialize()
      @store = YAML::Store.new('./data/test_store.yml')
      @table = @store.transaction{@store[:table]}
      @table = DJTable.new if @table == nil
    end

    def run()
      while true
        input = preprocess(gets.chomp)
        begin
          execute(input)
        rescue Standard => e
          puts e.message
        end
      end
    end

    def preprocess(str)
      str = str.downcase
      return str.split.join(" ")
    end

    # input is processed to words splited by 1 space
    # return the input command's category

    def execute(str)
      
      if str.match(/^exit\b/)
        save_and_exit
      elsif str.match(/^help\b/)
        @table.help

      elsif match = str.match(/^info track ([\s\S]*)/)
        @table.get_track_info(match.captures[0].to_i)

      elsif match = str.match(/^info artist ([\s\S]*)/)
        @table.get_artist_info(match.captures[0])

      elsif match = str.match(/^info\b/)
        @table.get_summary

      elsif match = str.match(/^count tracks by ([\s\S]*)/)
        @table.count_tracks(match.captures[0])

      elsif match = str.match(/^list tracks by ([\s\S]*)/)
        @table.list_track_by(match.captures[0])

      elsif match = str.match(/^add track ([\s\S]*) by ([\s\S]*)\b/)
        @table.add_track(match.captures[0], match.captures[1])

      elsif match = str.match(/^add artist ([\s\S]*)/)
        @table.add_artist(match.captures[0])

      else
        return "*** -IMS: command not found ***"
      end

    end

    def save
      @store.transaction do
        @store[:table] = @table
        @store[:last_run] = Time.now
      end
    end

    def save_and_exit
      save
      exit
    end
end