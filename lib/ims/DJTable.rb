require "./lib/ims/ArtistRecord.rb"

class DJTable

  def initialize(args = {})
    @id_to_record = {}
    @id_to_artist = {}
    @id_to_track = {}
    @played = []
  end

  attr_accessor :id_to_record
  attr_accessor :id_to_artist
  attr_accessor :id_to_track
  attr_accessor :played

  def get_summary()
    status = "Recently played tracks:\n"
    (0...3).each do |i|
       status << "#{played[played.length-1-i]}\n" if played.length > i
    end
    return status
  end

  def get_artist_info(artist_id)
    if !id_to_artist.key?(artist_id)
      raise ArgumentError.new("Error, artist id '#{artist_id}' does not exist")
    end
    record = id_to_record[artist_id]
    info = "Artist Name:\n#{record.name}\n"
    info << "Track Name, Track ID:\n"
    (0...record.tracks.length).each do |i|
      info << "#{record.tracks[i]}, #{record.track_ids[i]}\n"
    end
    return info
  end

  def list_track_by(artist_id)
    return get_artist_info(artist_id)
  end

  def get_track_info(track_id)
    if !id_to_track.key?(track_id)
      raise ArgumentError.new("Error, track id '#{track_id}' does not exist")
    end
    return "Track Name: #{id_to_track[track_id]}"
  end

  def count_tracks(artist_id)
    if !id_to_record.key?(artist_id)
      raise ArgumentError.new("Error, artist id '#{artist_id}' does not exist")
    end
    return id_to_record[artist_id].tracks.length
  end

  def assign_artist_id(artist)
    id = ""
    artist.split.each do |i|
      id << i[0]
    end
    return "#{id}#{id_to_artist.length}"
  end

  def assign_track_id(track)
    return id_to_track.length
  end

  def add_artist(artist)
    id = assign_artist_id(artist)
    id_to_record.update(id => ArtistRecord.new(artist))
    id_to_artist.update(id => artist)
    return "Successfully added, artist id '#{id}'"
  end

  def add_track(track, artist_id)
    if !id_to_artist.key?(artist_id)
      raise ArgumentError.new("Error, artist id '#{artist_id}' does not exist")
    end
    track_id = assign_track_id(track)
    id_to_track.update(track_id => track)
    id_to_record[artist_id].tracks.push(track)
    id_to_record[artist_id].track_ids.push(track_id)
    return "Successfully added, track id '#{track_id}'"
  end

  def play(track_id)
    if !id_to_track.key?(track_id)
      raise ArgumentError.new("Error, track id '#{track_id}' does not exist")
    end
    track = id_to_track[track_id]
    played.push(track)
    return "Playing track '#{track}'"
  end

  def help()
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
    return msg
  end

end
