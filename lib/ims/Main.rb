

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

      @hash = {
        "exit" => -> {save; exit},
        "help" => -> {@table.help},
        "info" => -> {@table.get_summary},
        "info artist" => -> {
          @table.get_artist_info(array[2])
        },
        "info track" => -> {
          @table.get_track_info(array[2])
        },
        "count tracks by" => -> {
          @table.count_tracks(array[3])
        },
        "list tracks by" => -> {
          @table.list_track_by(array[3])
        }, 
        "add artist" => -> {
          @table.add_artist(artist)
        },
        "add track" => -> {
          @table.add_track(track, artist_id)
        }
      }
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
      
      if match = str.match(/^(exit|help)\b/)
        @hash[match.captures[0]].call
        return "exit || help"
      elsif match = str.match(/^info track ([\s\S]*)/)
        @table.get_track_info(match.captures[0].to_i)
        return "info track", match.captures[0]

      elsif match = str.match(/^info artist ([\s\S]*)/)
        @table.get_artist_info(match.captures[0])
        return "info artist", match.captures[0]

      elsif match = str.match(/^info\b/)
        @table.get_summary
        return "info"

      elsif match = str.match(/^count tracks by ([\s\S]*)/)
        @table.count_tracks(match.captures[0])
        return "count tracks by", match.captures[0]

      elsif match = str.match(/^list tracks by ([\s\S]*)/)
        @table.list_track_by(match.captures[0])
        return "list tracks by", match.captures[0]

      elsif match = str.match(/^add track ([\s\S]*) by ([\s\S]*)\b/)
        @table.add_track(match.captures[0], match.captures[1])
        return "add track", match.captures[0], match.captures[1]

      elsif match = str.match(/^add artist ([\s\S]*)/)
        @table.add_artist(match.captures[0])
        return "add artist", match.captures[0]

      else
        return "not valid command"
      end

    end

    def save
      @store.transaction do
        @store[:table] = @table
        @store[:last_run] = Time.now
      end
    end
end