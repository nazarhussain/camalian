# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'
require 'minitest/spec'
require 'camalian'

describe Camalian::Quantization::Histogram do
  describe 'palette with 15 colors extracted' do
    before do
      @image = Camalian.load(File.join(File.dirname(__FILE__), '../assets/palette.png'))
      @palette = @image.prominent_colors(15, optimal: false, quantization: Camalian::QUANTIZATION_HISTOGRAM)
    end

    it 'must have 15 colors' do
      _(@palette.size).must_equal 15
    end

    it 'sort similar colors in order' do
      _(@palette.sort_similar_colors.map(&:to_hex)).must_equal PALLET_IMAGE_COLORS
    end
  end

  it 'should extract distinct colors' do
    colors = %w[#FF0000 #00FF00 #0000FF].map { |c| Camalian::Color.from_hex(c) }
    result = Camalian::Quantization::Histogram.new.process(colors, 3)

    _(result.size).must_equal 3
    _(result).must_equal colors
  end

  it 'should extract distinct colors lesser than pixels' do
    colors = %w[#FF0000 #00FF00 #0000FF].map { |c| Camalian::Color.from_hex(c) }
    result = Camalian::Quantization::Histogram.new.process(colors, 2)

    _(result.size).must_equal 2
  end

  it 'should extract distinct colors not more than pixels' do
    colors = %w[#FF0000 #00FF00 #0000FF].map { |c| Camalian::Color.from_hex(c) }
    result = Camalian::Quantization::Histogram.new.process(colors, 4)

    _(result.size).must_equal 3
  end

  it 'should extract same color' do
    colors = %w[#FF0000 #FF0000 #FF0000].map { |c| Camalian::Color.from_hex(c) }
    result = Camalian::Quantization::Histogram.new.process(colors, 3)

    _(result.size).must_equal 1
    _(result.to_hex).must_equal ['#ff0000']
  end

  it 'should extract multiple colors' do
    colors = %w[#FF0000 #FF0000 #00FF00 #0000FF].map { |c| Camalian::Color.from_hex(c) }
    result = Camalian::Quantization::Histogram.new.process(colors, 3)

    _(result.size).must_equal 3
    _(result.to_hex).must_equal %w[#ff0000 #00ff00 #0000ff]
  end
end
