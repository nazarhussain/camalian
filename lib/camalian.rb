# frozen_string_literal: true

require 'chunky_png'
require 'tempfile'
require 'open-uri'

require 'camalian/version'
require 'camalian/color'
require 'camalian/palette'
require 'camalian/image'
require 'camalian/quantization/histogram'
require 'camalian/quantization/k_means'

module Camalian # :nodoc:
  QUANTIZATION_HISTOGRAM = Camalian::Quantization::Histogram
  QUANTIZATION_K_MEANS = Camalian::Quantization::KMeans

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
