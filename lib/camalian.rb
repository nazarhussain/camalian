require "oily_png"
require "tempfile"
require "open-uri"
require "cocaine"
require "chunky_png_patch/color"

require "camalian/version"
require "camalian/color"
require "camalian/palette"
require "camalian/image"

module Camalian
  class << self
    def options
      convert = `which convert`.strip
      @options ||= {
          :image_magick_path  => convert.length > 0 ? convert : '/usr/bin/convert',
          :color_count        => 8,
      }
    end

    def load(image_path)      
      Image.new(image_path)
    end
  end
end
