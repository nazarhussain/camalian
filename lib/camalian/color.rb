module Camalian
  class Color

    attr_reader :r, :g, :b, :h, :s, :l, :hsv

    def initialize(*value)
      if value.size == 1
        rgb = extract_rgb(value.first)
        build_components(rgb[0], rgb[1], rgb[2])
      elsif value.size == 3
        build_components(value[0], value[1], value[2])
      end
    end

    def to_s
      "red=#{r} green=#{g} blue=#{b} hue=#{h} saturation=#{s} lightness=#{l}"
    end

    def to_hex
      "##{r.to_s(16).rjust(2, '0')}#{g.to_s(16).rjust(2, '0')}#{b.to_s(16).rjust(2, '0')}"
    end

    def distance(color)
      [(self.h - color.h) % 360, (color.h - self.h) % 360].min
    end

    def extract_rgb(color_hash)
      color_hash = color_hash[0..6]
      color_hash = color_hash[1..6] if color_hash[0] == '#'
      r = color_hash[0..1].to_i(16)
      g = color_hash[2..3].to_i(16)
      b = color_hash[4..5].to_i(16)
      [r, g, b]
    end

    private

    def build_components(r,g,b)
      @r = r
      @g = g
      @b = b

      ri = @r / 255.0
      gi = @g / 255.0
      bi = @b / 255.0

      cmax = [ri, gi, bi].max
      cmin = [ri, gi, bi].min
      delta = cmax - cmin

      @l = (cmax + cmin) / 2.0

      if delta == 0
        @h = 0
      elsif cmax == ri
        @h = 60 * (((gi - bi) / delta) % 6)
      elsif cmax == gi
        @h = 60 * (((bi - ri)/ delta) + 2)
      elsif cmax == bi
        @h = 60 * (((ri - gi)/ delta) + 4)
      end

      if (delta == 0)
        @s = 0
      else
        @s = delta / ( 1 - (2*@l -1).abs )
      end

      @h = @h.round(2)
      @s = (@s * 100).round(2)
      @l = (@l * 100).round(2)

      # HSV Calculation
      # Hue calculation
      if delta == 0
        @hsv = [0]
      elsif cmax == ri
        @hsv = [60 * (((gi - bi) / delta) % 6)]
      elsif cmax == gi
        @hsv = [60 * (((bi - ri)/ delta) + 2)]
      elsif cmax == bi
        @hsv = [60 * (((ri - gi)/ delta) + 4)]
      end

      # Saturation calculation
      if (cmax == 0)
        @hsv  << 0
      else
        @hsv << delta / cmax
      end

      # Value calculation
      @hsv << cmax

      @hsv = [@hsv[0].round(2), (@hsv[1] * 100).round(2), (@hsv[2] * 100).round(2)]
    end
  end
end
