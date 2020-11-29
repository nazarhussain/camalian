# frozen_string_literal: true

require 'test_helper'

describe Camalian::Quantization do
  [Camalian::Quantization::KMeans, Camalian::Quantization::Histogram].each do |klass|
    describe klass.name.to_s do
      it 'should extract distinct colors' do
        colors = %w[#FF0000 #00FF00 #0000FF].map { |c| Camalian::Color.from_hex(c) }
        result = klass.new.process(colors, 3)

        _(result.size).must_equal 3
        _(result).must_equal colors
      end

      it 'should extract distinct colors lesser than pixels' do
        colors = %w[#FF0000 #00FF00 #0000FF].map { |c| Camalian::Color.from_hex(c) }
        result = klass.new.process(colors, 2)

        _(result.size).must_equal 2
      end

      it 'should extract distinct colors not more than pixels' do
        colors = %w[#FF0000 #00FF00 #0000FF].map { |c| Camalian::Color.from_hex(c) }
        result = klass.new.process(colors, 4)

        _(result.size).must_equal 3
      end

      it 'should extract same color' do
        colors = %w[#FF0000 #FF0000 #FF0000].map { |c| Camalian::Color.from_hex(c) }
        result = klass.new.process(colors, 3)

        _(result.size).must_equal 1
        _(result.to_hex).must_equal ['#ff0000']
      end

      it 'should extract multiple colors' do
        colors = %w[#FF0000 #FF0000 #00FF00 #0000FF].map { |c| Camalian::Color.from_hex(c) }
        result = klass.new.process(colors, 3)

        _(result.size).must_equal 3
        _(result.to_hex).must_equal %w[#ff0000 #00ff00 #0000ff]
      end
    end
  end
end
