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

        Palette.new(buckets.map { |_, value| value.average_color }[0...count])
      end

      private

      def bucket_key(color, bucket_size)
        "#{color.r / bucket_size}:#{color.g / bucket_size}:#{color.b / bucket_size}"
      end
    end
  end
end
