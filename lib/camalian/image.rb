# frozen_string_literal: true

module Camalian
  # Load image into Camalian
  class Image
    attr_accessor :src_file_path

    def initialize(file_path)
      @src_file_path = file_path
    end

    def prominent_colors(count = Camalian.options[:color_count],
                         quantization: Camalian.options[:quantization],
                         optimal: true)
      image = ::ChunkyPNG::Image.from_file(@src_file_path)

      colors = image.pixels.map do |val|
        Color.new(
          ChunkyPNG::Color.r(val),
          ChunkyPNG::Color.g(val),
          ChunkyPNG::Color.b(val)
        )
      end

      quantize = Object.const_get("Camalian::Quantization::#{quantization.capitalize}").new

      palette = quantize.process(colors, count)

      retry_count = 1
      while !optimal && palette.size < count
        palette = quantize.process(colors, count + retry_count)
        retry_count += 1
      end

      palette
    end
  end
end
