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
    (0..record.tracks.length).each do |i|
      info << "#{record.tracks[i]}, #{record.track_ids[i]}\n"
    end
    return info
  end

  def get_track_info(track_id)
    if !id_to_track.key?(track_id)
      raise ArgumentError.new("Error, track id '#{track_id}' does not exist")
    end
    return "Track Name: #{id_to_track[track_id]}"
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
  end

  def add_track(track, artist_id)
    if !id_to_artist.key?(artist_id)
      raise ArgumentError.new("Error, artist id '#{artist_id}' does not exist")
    end
    track_id = assign_track_id(track)
    id_to_track.update(track_id => track)
    id_to_record[artist_id].tracks.push(track)
    id_to_record[artist_id].track_ids.push(track_id)
  end

  def play(track_id)
    if !id_to_track.key?(track_id)
      raise ArgumentError.new("Error, track id '#{track_id}' does not exist")
    end
    played.push(id_to_track[track_id])
  end

end
