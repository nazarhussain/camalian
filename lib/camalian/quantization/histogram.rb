# frozen_string_literal: true

module Camalian
  module Quantization
    class Histogram # :nodoc:
      def process(colors, count)
        bucket_size = (255.0 / count).ceil
        buckets = {}

        colors.each do |color|
          key = bucket_key(color, bucket_size)
          buckets[key] ||= Palette.new
          buckets[key].push(color)
        end

        buckets = buckets.values
        buckets = buckets.sort_by(&:size).reverse
        average_colors = buckets.map(&:average_color)
        Palette.new(average_colors[0...count])
      end

      private

      def bucket_key(color, bucket_size)
        "#{color.r / bucket_size}:#{color.g / bucket_size}:#{color.b / bucket_size}"
      end
    end
  end
end
