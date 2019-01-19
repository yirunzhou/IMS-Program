
class ArtistRecord

  def initialize(name)
    @name = name
    @tracks = []
    @track_ids = []
  end

  attr_accessor :name
  attr_accessor :tracks
  attr_accessor :track_ids

end
