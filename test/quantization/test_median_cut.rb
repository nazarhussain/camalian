# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'
require 'minitest/spec'
require 'camalian'

describe Camalian::Quantization::MedianCut do
  describe 'palette with 15 colors extracted' do
    before do
      @image = Camalian.load(File.join(File.dirname(__FILE__), '../assets/palette.png'))
      @palette = @image.prominent_colors(15, optimal: false, quantization: Camalian::QUANTIZATION_MEDIAN_CUT)
    end

    it 'must have 15 colors' do
      _(@palette.size).must_equal 15
    end

    it 'sort similar colors in order' do
      _(@palette.sort_similar_colors.map(&:to_hex)).must_equal ['#4dd915', '#49cc23', '#45c031', '#41b43f', '#3da84d',
                                                                '#399c5b', '#359069', '#318478', '#2d7886', '#296c94',
                                                                '#2560a2', '#2154b0', '#1d48be', '#193ccc', '#1530db']
    end
  end

  it 'should extract distinct colors' do
    colors = %w[#FF0000 #00FF00 #0000FF].map { |c| Camalian::Color.from_hex(c) }
    result = Camalian::Quantization::MedianCut.new.process(colors, 3)

    _(result.size).must_equal 3
    _(result.to_hex.sort).must_equal colors.map(&:to_hex).sort
  end

  it 'should extract distinct colors lesser than pixels' do
    colors = %w[#FF0000 #00FF00 #0000FF].map { |c| Camalian::Color.from_hex(c) }
    result = Camalian::Quantization::MedianCut.new.process(colors, 2)

    _(result.size).must_equal 2
  end

  it 'should extract distinct colors not more than pixels' do
    colors = %w[#FF0000 #00FF00 #0000FF].map { |c| Camalian::Color.from_hex(c) }
    result = Camalian::Quantization::MedianCut.new.process(colors, 4)

    _(result.size).must_equal 3
  end

  it 'should extract same color' do
    colors = %w[#FF0000 #FF0000 #FF0000].map { |c| Camalian::Color.from_hex(c) }
    result = Camalian::Quantization::MedianCut.new.process(colors, 3)

    _(result.size).must_equal 1
    _(result.to_hex).must_equal ['#ff0000']
  end

  it 'only: should extract multiple colors' do
    colors = %w[#FF0000 #FF0000 #00FF00 #0000FF].map { |c| Camalian::Color.from_hex(c) }
    result = Camalian::Quantization::MedianCut.new.process(colors, 3)

    _(result.size).must_equal 3
    _(result.to_hex).must_equal ['#ff0000', '#0000ff', '#00ff00']
  end
end
