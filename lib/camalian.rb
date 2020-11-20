# frozen_string_literal: true

require 'chunky_png'
require 'tempfile'
require 'open-uri'

require 'camalian/version'
require 'camalian/color'
require 'camalian/palette'
require 'camalian/image'
require 'camalian/quantization/histogram'

module Camalian # :nodoc:
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
