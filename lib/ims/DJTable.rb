require "./lib/ims/ArtistRecord.rb"


class DJTable

  def initialize(hash = {})
    # id => record
    @table = {}
    # played list
    @played = []
    @name_to_id = {}
  end


  attr_accessor :table
  attr_accessor :played
  attr_accessor :name_to_id


  def save()
  end

  def load()
  end

  def get_summary()
    status = ""
    (0...3).each do |i|
      status = status + "#{played[i]} \n" if played.length > i
    end
    return status
  end

  def get_artist_info()
  end

  def get_track_info()
  end

  def get_track_list()
  end


  # get unique id, need to deal with ambiguity
  def get_id(d_name)
    id = ""
    d_name.downcase.split.each do |i|
      id = id + i[0]
    end
    return id
  end

  # input first/last name should be sparate with 1 space
  def add_artist(name)
    name = name.downcase
    id = get_id(name)
    table.update(id => ArtistRecord.new(name))
    name_to_id.update(name => id)
  end


  def add_track(name, track)
    name = name.downcase
    track = track.downcase

    if table[id] == nil
      print "Artist not exisits!"
      return
    end

    table[id].tracks.push(track)

    # how to deal with message
    print "Add track #{track} to artisit with id: #{id} \n"
  end



  def play(name, track)
    name = name.downcase
    track = track.downcase
    id = name_to_id[name]

    if table[id].tracks.include?(track)
      # add to played
      played.push(track)
      if played.length > 3
        played.shift
      end
    end

    # error?
  end

end
