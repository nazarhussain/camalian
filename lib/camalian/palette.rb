# frozen_string_literal: true

module Camalian
  # Collection of colors with some useful features
  class Palette < Array
    def sort_by_lightness
      Palette.new(sort_by(&:l).reverse)
    end

    def sort_by_hue
      Palette.new(sort_by(&:h).reverse)
    end

    def sort_similar_colors
      Palette.new(sort_by(&:hsv))
    end

    def sort_by_saturation
      Palette.new(sort_by(&:s).reverse)
    end

    def average_color
      r = map(&:r).inject(&:+)
      g = map(&:g).inject(&:+)
      b = map(&:b).inject(&:+)
      size = self.size

      Color.new(r / size, g / size, b / size)
    end

    def light_colors(limit1, limit2)
      min = [limit1, limit2].min
      max = [limit1, limit2].max
      table = dup
      Palette.new(table.delete_if { |color| color.l > max or color.l < min })
    end
  end
end
