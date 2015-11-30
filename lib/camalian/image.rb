require 'rmagick'

module Camalian
  class Image
    attr_accessor :src_file_path

    def initialize(file_path)
      @src_file_path = file_path
    end

    def prominent_colors(count=Camalian.options[:color_count])
      image = ::Magick::Image.read(@src_file_path)[0]
      image.resize!(100,100)
      colors = Palette.new
      initial_count = count
      q = nil
      loop do
        q = image.quantize(initial_count, Magick::RGBColorspace)
        break if q.color_histogram.size > count
        initial_count = initial_count + 10
      end
      palette = q.color_histogram.sort {|a, b| b[1] <=> a[1]}
      (0..[count, palette.count].min - 1).each do |i|
          c = palette[i].first.to_s.split(',').map {|x| x[/\d+/]}
          c.pop
          c[0], c[1], c[2] = [c[0], c[1], c[2]].map { |s|
              s = s.to_i
              s = s / 256 if s / 256 > 0 # not all ImageMagicks are created equal....
              s
          }
          colors << Color.new(c[0],c[1],c[2])
      end
      return colors.uniq(&:to_hex)
    end
  end
end
