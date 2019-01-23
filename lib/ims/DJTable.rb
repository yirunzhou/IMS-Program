require "./lib/ims/ArtistRecord.rb"
require 'yaml/store'

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

  # TODO: move validation of argument to another function
  # TODO: check track_id is something like 1o09asdjnd, not valid

  def info()
    status = "Recently played tracks:\n"
    (0...3).each do |i|
      status << "\t#{played[played.length-1-i]}\n" if played.length > i
    end

    status << "Artist Name, Artist ID:\n"
    @id_to_artist.each do |k, v|
      status << "\t#{v}, #{k}\n"
    end
    return status
  end

  def info_artist(artist_id)
    if !id_to_artist.key?(artist_id)
      raise ArgumentError.new("Error, artist id '#{artist_id}' does not exist")
    end
    record = id_to_record[artist_id]
    info = "Artist Name:\n\t#{record.name}\n"
    info << "Track Name, Track ID:\n"
    (0...record.tracks.length).each do |i|
      info << "\t#{record.tracks[i]}, #{record.track_ids[i]}\n"
    end
    return info
  end

  def info_track(track_id)
    if !track_id.numeric?
      raise ArgumentError.new("Error, invalid track id")
    end
    track_id = track_id.to_i
    if !id_to_track.key?(track_id)
      raise ArgumentError.new("Error, track id '#{track_id}' does not exist")
    end
    artist = ""
    @id_to_record.each do |k, v|
      if v.track_ids.include? track_id
        artist = v.name
        break
      end
    end
    return "Track Name: #{id_to_track[track_id]}, Artist Name: #{artist}"
  end

  def count_tracks_by(artist_id)
    if !id_to_record.key?(artist_id)
      raise ArgumentError.new("Error, artist id '#{artist_id}' does not exist")
    end
    return id_to_record[artist_id].tracks.length.to_s
  end

  def list_tracks_by(artist_id)
    return info_artist(artist_id)
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
    record = id_to_record[artist_id]
    if record.tracks.include? track
      raise ArgumentError.new("Error, track '#{track}' already exists")
    end
    track_id = assign_track_id(track)
    id_to_track.update(track_id => track)
    record.tracks.push(track)
    record.track_ids.push(track_id)
    return "Successfully added, track id '#{track_id}'"
  end

  def play(track_id)
    if !track_id.numeric?
      raise ArgumentError.new("Error, invalid track id")
    end
    track_id = track_id.to_i
    if !id_to_track.key?(track_id)
      raise ArgumentError.new("Error, track id '#{track_id}' does not exist")
    end
    track = id_to_track[track_id]
    played.push(track)
    return "Playing track '#{track}'"
  end

  def help()
    store = YAML::Store.new('./data/help_msg.yml')
    return store.transaction{store[:help_msg]}
  end

  ### aux functions ###
  def assign_artist_id(artist)
    if @id_to_artist.has_value? artist
      raise ArgumentError.new("Error, artist '#{artist}' already exists")
    end
    id = ""
    artist.split.each do |i|
      id << i[0]
    end
    return "#{id}#{id_to_artist.length}"
  end

  def assign_track_id(track)
    if @id_to_track.has_value? track
      raise ArgumentError.new("Error, track '#{track}' already exists")
    end
    return id_to_track.length
  end

end


class String
  def numeric?
    Float(self) != nil rescue false
  end
end