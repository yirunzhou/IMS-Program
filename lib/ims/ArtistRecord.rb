
class ArtistRecord

  def initialize(name)
    @name = name
    @tracks = Array.new()
  end

  attr_accessor :name
  attr_accessor :tracks


end
