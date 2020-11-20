require 'minitest/autorun'
require 'minitest/spec'
require 'camalian'

describe Camalian::Image do

end

PALLET_IMAGE_COLORS = %W(#4dd915 #49cc23 #45c031 #41b43f #3da84d #399c5b #359069 #318478 #2d7886 #296c94 #2560a2 #2154b0 #1d48be #193ccc #1530db)

describe Camalian::Palette do
  before do
    @image = Camalian::load( File.join( File.dirname(__FILE__), 'assets/palette.png'))
    @palette = @image.prominent_colors(15, optimal: false)
  end

  describe "palette with 15 colors extracted" do
    it "must have 15 colors" do
      _(@palette.size).must_equal 15
    end

    it "sort similar colors in order" do
      _(@palette.sort_similar_colors.map(&:to_hex)).must_equal PALLET_IMAGE_COLORS
    end

    it "color with intensity 0-40 works well" do
      _(@palette.light_colors(0, 40).map(&:to_hex)).must_equal %W(#2560a2 #296c94 #2d7886 #318478 #359069)
    end
  end
end
