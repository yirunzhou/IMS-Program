require "./lib/ims.rb"
require "./lib/ims/DJTable.rb"
require "./lib/ims/ArtistRecord.rb"
require "test/unit"

class TestIms < Test::Unit::TestCase

  def test_sample
    assert_equal(4, 2+2)
  end

  def test_record
    name = "MJ"
    tracks = ["t1", "t2"]
    sample = ArtistRecord.new(name)
    assert_equal(name, sample.name)

    sample.tracks = tracks
    assert_equal(tracks, sample.tracks)

    sample.tracks.push("t3")
    assert_equal("t3", sample.tracks.last)
  end

  def test_table
    sample = DJTable.new()
    assert_equal("hfz1", sample.get_id("Hello from zzz 111"))

    sample.add_artist("Micheal Jackson")
    assert_equal("micheal jackson", sample.table["mj"].name)

    sample.add_track("Micheal jackson", "jam")
    sample.add_track("micheal Jackson", "beat it")
    sample.add_track("asdfskdjf", "sajkksmd")
    sample.add_track("micheal Jackson", "abc")

    sample.add_track("micheal jackson", "thriller")

    sample.play("micheal jackson", "jam")

    sample.play("micheal jackson", "beat it")
    sample.play("micheal jackson", "abc")
    sample.play("micheal jackson", "thriller")

    assert_equal("beat it \nabc \nthriller \n", sample.get_status())

  end

  

end
