require "chunky_png"
require "tempfile"
require "open-uri"
require "chunky_png_patch/color"

require "camalian/version"
require "camalian/color"
require "camalian/palette"
require "camalian/image"
require "camalian/quantization/histogram"

module Camalian
  QUANTIZATION_HISTOGRAM = 'histogram'

  class << self
    def options
      @options ||= {
        color_count: 8,
        quantization: Camalian::QUANTIZATION_HISTOGRAM
      }
    end

    def load(image_path)      
      Image.new(image_path)
    end
  end
end
