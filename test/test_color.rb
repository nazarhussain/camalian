require 'minitest/autorun'
require 'minitest/spec'
require 'camalian'

describe Camalian::Color do
  before do
    @color = Camalian::Color.new(120,255,30)
  end

  describe "Color initialized with 120, 255, 30 rgb values" do
    it "hex value must be #78ff1e" do
      @color.to_hex.must_equal "#78ff1e"
    end

    it "hsl color components must " do
      [@color.h.to_i, @color.s.to_i, @color.l.to_i].must_equal [96, 100, 55]
    end

    it "hsv color components must " do
      @color.hsv.map(&:to_i).must_equal [96, 88, 100]
    end
  end

  describe "initialized with 1 integer rgb value" do
    it "must have leading zero" do
      Camalian::Color.new(7, 7, 7).to_hex.must_equal "#070707"
    end
  end
end
