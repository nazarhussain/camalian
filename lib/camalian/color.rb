# frozen_string_literal: true

module Camalian
  # Camalian color object
  class Color
    attr_reader :r, :g, :b, :h, :s, :l, :hsv

    def initialize(r, g, b)
      build_components(r, g, b)
    end

    def self.from_hex(hex_value)
      r, g, b = extract_rgb(hex_value)
      Color.new(r, g, b)
    end

    def to_s
      "red=#{r} green=#{g} blue=#{b} hue=#{h} saturation=#{s} lightness=#{l}"
    end

    def to_hex
      "##{r.to_s(16).rjust(2, '0')}#{g.to_s(16).rjust(2, '0')}#{b.to_s(16).rjust(2, '0')}"
    end

    def distance(color)
      [(h - color.h) % 360, (color.h - h) % 360].min
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

    def build_components(r, g, b)
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

      if delta.zero?
        @h = 0
      elsif cmax == ri
        @h = 60 * (((gi - bi) / delta) % 6)
      elsif cmax == gi
        @h = 60 * (((bi - ri) / delta) + 2)
      elsif cmax == bi
        @h = 60 * (((ri - gi) / delta) + 4)
      end

      @s = if delta.zero?
             0
           else
             delta / (1 - (2 * @l - 1).abs)
           end

      @h = @h.round(2)
      @s = (@s * 100).round(2)
      @l = (@l * 100).round(2)

      # HSV Calculation
      # Hue calculation
      if delta.zero?
        @hsv = [0]
      elsif cmax == ri
        @hsv = [60 * (((gi - bi) / delta) % 6)]
      elsif cmax == gi
        @hsv = [60 * (((bi - ri) / delta) + 2)]
      elsif cmax == bi
        @hsv = [60 * (((ri - gi) / delta) + 4)]
      end

      # Saturation calculation
      @hsv << if cmax.zero?
                0
              else
                delta / cmax
              end

      # Value calculation
      @hsv << cmax

      @hsv = [@hsv[0].round(2), (@hsv[1] * 100).round(2), (@hsv[2] * 100).round(2)]
    end
  end
end
