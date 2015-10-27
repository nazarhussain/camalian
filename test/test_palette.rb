require 'minitest/autorun'
require 'minitest/spec'
require 'camalian'

describe Camalian::Image do

end

describe Camalian::Palette do
  before do
    @image = Camalian::load( File.join( File.dirname(__FILE__), 'assets/palette.png'))
    @palette = @image.prominent_colors(15)
  end

  describe "palette with 15 colors extracted" do
    it "must have 15 colors" do
      @palette.size.must_equal 15
    end

    it "sort similar colors in order" do
      @palette.sort_similar_colors.map(&:to_hex).must_equal %W(#4dda15 #45c131 #41b53f #3da94d #3da84e #359169 #318578 #2d7986 #296d94 #2560a3 #2154b1 #1d48bf #193dcd #193cce #1530dc)
    end

    it "color with intensity 0-40 works well" do
      @palette.light_colors(0, 40).map(&:to_hex).must_equal %W(#318578 #2560a3 #359169 #296d94 #2d7986)
    end
  end
end
