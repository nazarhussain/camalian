module Camalian
  class Palette < Array

    def sort_by_lightness
      Palette.new(self.sort_by { |a| a.l }.reverse)
    end

    def sort_by_hue
      Palette.new(self.sort_by { |a| a.h }.reverse)
    end

    def sort_similar_colors
      Palette.new(self.sort_by { |a| a.hsv })
    end

    def sort_by_saturation
      Palette.new(self.sort_by { |a| a.s }.reverse)
    end

    def light_colors(limit1, limit2)
      min = [limit1, limit2].min
      max = [limit1, limit2].max
      table = self.dup
      Palette.new(table.delete_if { |color| color.l > max or color.l < min })
    end
  end
end
