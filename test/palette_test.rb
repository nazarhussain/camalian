# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'
require 'minitest/spec'
require 'camalian'

describe Camalian::Palette do
  before do
    mixed_colors = %w[#2560a2 #4dd915 #1530db #49cc23 #45c031 #3da84d #1d48be #399c5b #359069 #318478 #2d7886 #296c94
                      #2154b0 #193ccc #41b43f].freeze

    @palette = Camalian::Palette.from_hex(mixed_colors)
  end

  it 'initialize palette with correct size' do
    _(@palette.size).must_equal 15
  end

  describe '#sort_by_lightness' do
    it 'sort colors by lightness ' do
      _(@palette.sort_by_lightness.to_hex).must_equal ['#41b43f', '#45c031', '#1530db', '#49cc23', '#4dd915',
                                                       '#193ccc', '#3da84d', '#1d48be', '#399c5b', '#2154b0',
                                                       '#2560a2', '#359069', '#296c94', '#318478', '#2d7886']
    end
  end

  describe '#sort_by_hue' do
    it 'sort colors by hue' do
      _(@palette.sort_by_hue.to_hex).must_equal ['#1530db', '#193ccc', '#1d48be', '#2154b0', '#2560a2', '#296c94',
                                                 '#2d7886', '#318478', '#359069', '#399c5b', '#3da84d', '#41b43f',
                                                 '#45c031', '#49cc23', '#4dd915']
    end
  end

  describe '#sort_by_saturation' do
    it 'sort colors by saturation' do
      _(@palette.sort_by_saturation.to_hex).must_equal ['#1530db', '#4dd915', '#193ccc', '#1d48be', '#49cc23',
                                                        '#2154b0', '#2560a2', '#45c031', '#296c94', '#2d7886',
                                                        '#41b43f', '#3da84d', '#399c5b', '#359069', '#318478']
    end
  end

  describe '#sort_similar_colors' do
    it 'sort colors by hsv' do
      _(@palette.sort_similar_colors.to_hex).must_equal ['#4dd915', '#49cc23', '#45c031', '#41b43f', '#3da84d',
                                                         '#399c5b', '#359069', '#318478', '#2d7886', '#296c94',
                                                         '#2560a2', '#2154b0', '#1d48be', '#193ccc', '#1530db']
    end
  end

  describe '#average_color' do
    it 'return one average color' do
      _(@palette.average_color.to_hex).must_equal '#318477'
    end
  end

  describe '#light_colors' do
    it 'extract light colors in provided limit' do
      _(@palette.light_colors(40, 90).to_hex).must_equal ['#4dd915', '#1530db', '#49cc23', '#45c031', '#3da84d',
                                                          '#1d48be', '#399c5b', '#2154b0', '#193ccc', '#41b43f']
    end
  end
end
