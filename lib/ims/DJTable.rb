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
    validation(:artist_id => artist_id)
    record = id_to_record[artist_id]
    info = "Artist Name:\n\t#{record.name}\n"
    info << "Track Name, Track ID:\n"
    (0...record.tracks.length).each do |i|
      info << "\t#{record.tracks[i]}, #{record.track_ids[i]}\n"
    end
    return info
  end

  def info_track(track_id)
    validation(:track_id => track_id)
    track_id = track_id.to_i
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
    validation(:artist_id => artist_id)
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
    validation(:artist_id => artist_id)
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
    validation(:track_id => track_id)
    track_id = track_id.to_i
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
    validation(:artist => artist)
    id = ""
    artist.split.each do |i|
      id << i[0]
    end
    return "#{id}#{id_to_artist.length}"
  end

  def assign_track_id(track)
    return id_to_track.length
  end

  def validation(args)
    if args[:artist_id] != nil 
      artist_id = args[:artist_id]
      raise ArgumentError.new("Error, artist id '#{artist_id}' does not exist") if !@id_to_artist.key? artist_id
    end
    if args[:track_id] != nil
      track_id = args[:track_id]
      raise ArgumentError.new("Error, invalid track id") if !is_numeric? track_id
      track_id = track_id.to_i
      raise ArgumentError.new("Error, track id '#{track_id}' does not exist") if !@id_to_track.key? track_id
    end
    if args[:artist] != nil
      artist = args[:artist]
      raise ArgumentError.new("Error, artist '#{artist}' already exists") if @id_to_artist.has_value? artist
    end
  end

  def is_numeric?(id)
    Float(id) != nil rescue false
  end
end